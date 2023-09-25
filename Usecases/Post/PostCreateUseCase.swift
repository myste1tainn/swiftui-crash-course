//
//  struct PostCreateUseCase.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import Foundation

protocol PostCreateUseCase {
    func execute(request: PostCreateRequest) async
}

struct DefaultPostCreateUseCase: PostCreateUseCase {
    let api: PostAPI = DefaultPostAPI()
    
    func execute(request: PostCreateRequest) async {
        try! await api.create(request: request)
    }
}

struct PostCreateRequest: Encodable {
    let userId: Int = 1
    let title: String
    let body: String
    let author: String = "THE CHAPTER"
}
