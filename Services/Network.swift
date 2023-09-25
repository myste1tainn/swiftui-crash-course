//
//  Service.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import Foundation
import Alamofire

struct Network {
    static let shared = Network.init()
    let baseUrlString = "http://localhost:3000"
    let headers = HTTPHeaders(["Content-Type": "application/json"])
    
    func request<T: Decodable>(method: HTTPMethod = .get, path: String) async throws -> T {
        try await performRequest(dataRequest: AF.request(baseUrlString + path, method: method, headers: headers))
    }
    
    func request<T: Decodable, P: Encodable>(method: HTTPMethod = .get, path: String, parameters: P) async throws -> T {
        try await performRequest(dataRequest: AF.request(baseUrlString + path, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers))
    }
    
    func request(method: HTTPMethod = .get, path: String) async throws {
        try await performRequest(dataRequest: AF.request(baseUrlString + path, method: method, headers: headers))
    }
    
    func request<P: Encodable>(method: HTTPMethod = .get, path: String, parameters: P) async throws {
        try await performRequest(dataRequest: AF.request(baseUrlString + path, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers))
    }
    
    
    private func performRequest<T: Decodable>(dataRequest: DataRequest) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            dataRequest.responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(object):
                    continuation.resume(returning: object)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }.cURLDescription { description in print(description) }
        }
    }
    
    private func performRequest(dataRequest: DataRequest) async throws {
        try await withCheckedThrowingContinuation { continuation in
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    continuation.resume()
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }.cURLDescription { description in print(description) }
        }
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
