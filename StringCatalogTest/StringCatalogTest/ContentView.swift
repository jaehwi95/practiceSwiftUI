//
//  ContentView.swift
//  StringCatalogTest
//
//  Created by Jaehwi Kim on 2024/03/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, world!")
            CustomText("Hello Custom Text")
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}

struct CustomText: View {
    let text: String
    let font: Font?
    let textColor: Color?
    
    init(
        _ text: String,
        font: Font? = .system(size: 14, weight: .medium, design: .default),
        textColor: Color? = Color(.systemGray)
    ) {
        self.text = text
        self.font = font
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(textColor)
    }
}

struct CustomTextField: View {
    let text: Binding<String>
    let label: String?
    let placeHolder: String?
    let errorMessage: Binding<String>?
    
    init(
        text: Binding<String>,
        label: String? = nil,
        placeHolder: String?,
        errorMessage: Binding<String>? = .constant("")
    ) {
        self.text = text
        self.label = label
        self.placeHolder = placeHolder
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let label = self.label {
                CustomText(label)
            }
            TextField("", text: self.text, prompt: Text(self.placeHolder ?? ""))
            if self.errorMessage?.wrappedValue != "" {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
