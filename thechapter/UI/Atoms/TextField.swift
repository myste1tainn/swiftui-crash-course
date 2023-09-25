//
//  TextField.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import SwiftUI

struct TextField: View {
    var title: String = ""
    var text: Binding<String>
    @FocusState var fieldFocused: Bool
    
    var body: some View {
        SwiftUI.TextField(
            title,
                text: text
            )
            .focused($fieldFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
    }
}
