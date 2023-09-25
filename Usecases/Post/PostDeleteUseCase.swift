//
//  PostDeleteUseCase.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import Foundation

protocol PostDeleteUseCase {
    func execute(request: PostDeleteRequest) async
}

struct DefaultPostDeleteUseCase: PostDeleteUseCase {
    let api: PostAPI = DefaultPostAPI()
    
    func execute(request: PostDeleteRequest) async {
        try! await api.delete(request: request)
    }
}

struct PostDeleteRequest {
    let id: Int
}
