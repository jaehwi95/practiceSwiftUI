//
//  ContentView.swift
//  TextfieldTest
//
//  Created by Jaehwi Kim on 2024/07/02.
//

import SwiftUI

struct ContentView: View {
    @State fileprivate var password = ""
    @State fileprivate var isShowPassword = false
    
    var body: some View {
        HStack {
            Group {
                if isShowPassword {
                    TextField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                } else {
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
            Group {
                if isShowPassword {
                    Button(
                        action: {
                            isShowPassword.toggle()
                        },
                        label: {
                            Image(systemName: "eye")
                        }
                    )
                } else {
                    Button(
                        action: {
                            isShowPassword.toggle()
                        },
                        label: {
                            Image(systemName: "eye.slash")
                        }
                    )
                }
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            let nullableList: [Double?]? = []
            let sum = nullableList?.compactMap {
                $0
            }.reduce(0, +)
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
//    var textBinding: Binding<String> {
//        Binding(
//            get: { password },
//            set: { value in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    password = value
//                }
//            }
//        )
//    }
}
