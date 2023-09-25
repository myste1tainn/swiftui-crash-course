//
//  ContentView.swift
//  thechapter
//
//  Created by arnon.keereena on 13/9/2566 BE.
//

import SwiftUI

struct PostListView: View {
    @State private var posts: [Post] = []
    
    let usecases: UseCases = .init()
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(posts, id: \.id) {
                        PostListItemView(title: $0.title, description: $0.body ?? "", author: $0.author)
                    }.onDelete(perform: deleteItem)
                }
                Button(action: {}) {
                    NavigationLink(destination: CreatePostView()) {
                        Text("Create Post")
                    }
                }
               
            }
            .navigationTitle("Post List")
            .task {
                posts = await usecases.postList.execute()
            }
        }
    }
    
    private func deleteItem(_ indexSet: IndexSet) {
        Task {
            await usecases.postDelete.execute(request: .init(id: indexSet.map{posts[$0].id}.first!))
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}

extension PostListView {
    struct UseCases {
        let postList: PostListUseCase = DefaultPostListUseCase()
        let postDelete: PostDeleteUseCase = DefaultPostDeleteUseCase()
    }
}
