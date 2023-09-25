//
//  Button.swift
//  thechapter
//
//  Created by arnon.keereena on 15/9/2566 BE.
//

import SwiftUI

struct Button<Label>: View where Label: View {
    var action: () -> Void
    var label:  () -> Label
    
    init(action: @escaping () -> Void = {},
         label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }
    
    var body: some View {
        SwiftUI.Button(action: action, label: label)
            .buttonStyle(.borderedProminent)
            .foregroundColor(.green)
            .tint(.red)
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Button()
    }
}

extension Button where Label == Text {
    init(_ title: String = "Button",
         action: @escaping () -> Void = {}) {
        self.action = action
        self.label = { Text(title) }
    }
}
