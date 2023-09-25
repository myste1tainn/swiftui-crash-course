//
//  PostListItemView.swift
//  thechapter
//
//  Created by arnon.keereena on 14/9/2566 BE.
//

import SwiftUI

struct PostListItemView: View {
    let title: String
    let description: String
    let author: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).bold()
            Text(description).font(.system(size: 12)).foregroundColor(.gray)
            Text(author).font(.system(size: 12)).foregroundColor(.blue)
        }
    }
}

struct PostListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostListItemView(title: "Lorem ipsum",
                         description: "Dolor sit ameri, qua xan zui",
                         author: "John Doe")
    }
}
