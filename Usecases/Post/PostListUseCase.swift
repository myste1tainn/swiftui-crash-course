//
//  Post.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import Foundation

protocol PostListUseCase {
    func execute() async -> [Post]
}

struct DefaultPostListUseCase: PostListUseCase {
    let api: PostAPI = DefaultPostAPI()

    func execute() async -> [Post] {
        try! await api.fetchAll()
    }
}
