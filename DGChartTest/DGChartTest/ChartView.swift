//
//  ChartView.swift
//  DGChartTest
//
//  Created by Jaehwi Kim on 2024/08/30.
//

import SwiftUI
import DGCharts

struct TestChart: UIViewRepresentable {
    let entries: [ChartDataEntry]
    
    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()
        chartView.data = setChartData()
        chartView.isUserInteractionEnabled = false
        chartView.legend.enabled = false
        chartView.chartDescription.enabled = false
        chartView.drawGridBackgroundEnabled = false
        
        chartView.configureXAxis()
        chartView.configureLeftAxis()
        chartView.configureRightAxis()
        chartView.notifyDataSetChanged()
        print("chart makeUI called")
        return chartView
    }
    
    func updateUIView(_ chartView: LineChartView, context: Context) {
        chartView.clear()
        chartView.data = setChartData()
        if self.entries.isEmpty {
            chartView.leftAxis.axisMinimum = 0
            print("chart leftAxis set")
        }
        print("chart updateUI, \(chartView.leftAxis.axisMinimum)")
    }
    
    private func setChartData() -> LineChartData {
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.drawCirclesEnabled = true
        dataSet.drawFilledEnabled = false
        dataSet.circleRadius = 4
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.circleColors = [UIColor.blue]
        return LineChartData(dataSet: dataSet)
    }
    
    typealias UIViewType = LineChartView
}

private extension LineChartView {
    func configureXAxis() {
        self.xAxis.drawAxisLineEnabled = false
        self.xAxis.drawLabelsEnabled = true
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.labelPosition = .bottom
        self.xAxis.labelCount = 6
        self.xAxis.granularity = 1
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["00", "04", "08", "12", "16", "20"])
        self.xAxis.axisMinimum = 0
        self.xAxis.axisMaximum = 5
        self.xAxis.forceLabelsEnabled = true
        self.xAxis.setLabelCount(6, force: true)
        self.setVisibleXRange(minXRange: 0, maxXRange: 5)
        self.xAxis.avoidFirstLastClippingEnabled = true
    }
    
    func configureRightAxis() {
        self.rightAxis.drawGridLinesEnabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.rightAxis.drawLabelsEnabled = false
    }
    
    func configureLeftAxis() {
        self.leftAxis.drawGridLinesEnabled = false
        self.leftAxis.drawAxisLineEnabled = false
        self.leftAxis.drawLabelsEnabled = false
    }
}
