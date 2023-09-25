//
//  CreatePostView.swift
//  thechapter
//
//  Created by arnon.keereena on 14/9/2566 BE.
//

import SwiftUI

struct CreatePostView: View {
    @State private var title: String = ""
    @FocusState private var titleFieldFocused: Bool
    
    @State private var description: String = ""
    @FocusState private var descriptionFieldFocused: Bool
    
    let usecases: UseCases = .init()
    
    var body: some View {
        VStack {
            VStack {
                TextField(
                    title: "Title",
                    text: $title
                )
                TextField(
                    title: "Description",
                    text: $description
                )
            }.padding()
            
            Button("Submit", action: createPost)
        }.navigationTitle("Create Post")
    }
    
    private func createPost() {
        Task {
            await usecases.postCreate.execute(request: .init(title: title, body: description))
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}

extension CreatePostView {
    struct UseCases {
        let postCreate: PostCreateUseCase = DefaultPostCreateUseCase()
    }
}
