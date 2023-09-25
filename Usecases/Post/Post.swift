//
//  Post.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import Foundation

struct Post: Decodable {
    let userId: Int?
    let id: Int
    let title: String
    let author: String
    let body: String?
}
