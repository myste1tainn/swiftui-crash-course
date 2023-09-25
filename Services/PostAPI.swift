//
//  PostService.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import Foundation

protocol PostAPI {
    func fetchAll() async throws -> [Post]
    func create(request: PostCreateRequest) async throws
    func delete(request: PostDeleteRequest) async throws
}

struct DefaultPostAPI: PostAPI {
    func delete(request: PostDeleteRequest) async throws {
        try await Network.shared.request(method: .delete, path: "/posts/\(request.id)")
    }
    
    func fetchAll() async throws -> [Post] {
        try await Network.shared.request(path: "/posts")
    }
    
    func create(request: PostCreateRequest) async throws {
        try await Network.shared.request(method: .post, path: "/posts", parameters: request)
    }
}
