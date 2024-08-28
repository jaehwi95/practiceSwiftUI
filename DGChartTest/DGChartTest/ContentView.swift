//
//  ContentView.swift
//  DGChartTest
//
//  Created by Jaehwi Kim on 2024/08/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                
                NavigationLink("Navigate", destination: DetailView())
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
