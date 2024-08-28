//
//  DetailView.swift
//  DGChartTest
//
//  Created by Jaehwi Kim on 2024/08/28.
//

import SwiftUI
import UIKit

struct DetailView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello, World!")
                    .frame(maxWidth: .infinity)
                    .frame(height: 1000, alignment: .top)
                Text("Hello, World!")
                    .frame(maxWidth: .infinity)
                    .frame(height: 1000)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("Button")
                    }
                )
            }
            ToolbarItem(placement: .principal) {
                Text("Title")
                    .font(.system(size: 20))
            }
        }
//        .toolbarBackground(Color.white, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        DetailView()
    }
}
