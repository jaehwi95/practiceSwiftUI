//
//  ContentView.swift
//  DGChartTest
//
//  Created by Jaehwi Kim on 2024/08/28.
//

import SwiftUI
import DGCharts

struct ContentView: View {
    @State var chartDataEntries: [ChartDataEntry] = [
        ChartDataEntry(x: 0, y: 32),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                TestChart(
                    entries: chartDataEntries
                )
                .frame(height: 200)
                .border(.red)
                Button {
                    self.chartDataEntries = [
                        ChartDataEntry(x: 0, y: 32),
                        ChartDataEntry(x: 1, y: 45),
                        ChartDataEntry(x: 2, y: 11),
                        ChartDataEntry(x: 3, y: 68),
                        ChartDataEntry(x: 4, y: 2),
                        ChartDataEntry(x: 5, y: 45)
                    ]
                } label: {
                    Text("Set Data")
                }
                Button {
                    self.chartDataEntries = []
                } label: {
                    Text("Empty Data")
                }
//                NavigationLink("Navigate", destination: DetailView())
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
