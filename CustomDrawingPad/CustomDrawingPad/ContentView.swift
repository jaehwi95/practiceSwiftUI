//
//  ContentView.swift
//  CustomDrawingPad
//
//  Created by Jaehwi Kim on 2024/07/04.
//

import SwiftUI

struct ContentView: View {
    @State private var drawingBounds: CGRect = .zero
    @State private var drawing = DrawingPath()
    @State private var color = Color.blue
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer()
                SignatureDrawView(drawing: $drawing, color: $color)
                    .padding(.bottom, 20)
                Button(
                    action: {
                        self.drawing = DrawingPath()
                    },
                    label: {
                        Text("Clear")
                    }
                )
                .padding(.bottom, 20)
                Text(self.drawing.isEmpty ? "Cannot Next" : "Next!")
                Spacer()
            }.frame(height: 1000)
        }
    }
}

private let bigFontSize: CGFloat = 44
private let placeholderText = "Signature"
private let maxHeight: CGFloat = 160
private let lineWidth: CGFloat = 8

struct SignatureDrawView: View {
    @Binding var drawing: DrawingPath
    @Binding var color: Color
    
    @State private var drawingBounds: CGRect = .zero
    
    var body: some View {
        ZStack {
            Color.white
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: FramePreferenceKey.self,
                                           value: geometry.frame(in: .local))
                })
                .onPreferenceChange(FramePreferenceKey.self) { bounds in
                    drawingBounds = bounds
                }
            if drawing.isEmpty {
                Text(placeholderText)
                    .foregroundColor(.gray)
                    .font(.system(size: bigFontSize))
            } else {
                DrawShape(drawingPath: drawing)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color)
            }
        }
        .frame(height: maxHeight)
        .gesture(DragGesture(minimumDistance: 0.0)
            .onChanged { value in
                print("jaebi change \(drawing)")
                if drawingBounds.contains(value.location) {
                    drawing.addPoint(value.location)
                } else {
                    drawing.addBreak()
                }
            }
            .onEnded { value in
                drawing.addBreak()
                print("jaebi end \(drawing)")
            }
        )
        .overlay(RoundedRectangle(cornerRadius: 4)
            .stroke(Color.gray))
    }
}

struct DrawingPath {
    private(set) var points: [CGPoint] = [CGPoint]()
    private var breaks: [Int] = [Int]()
    
    var isEmpty: Bool {
        points.isEmpty
    }
    
    var allPoints: String {
        points.map { item in
            "\(item)"
        }.joined(separator: " ")
    }
    
    var allBreaks: String {
        breaks.map { item in
            "\(item)"
        }.joined(separator: " ")
    }
    
    mutating func addPoint(_ point: CGPoint) {
        points.append(point)
    }
    
    mutating func addBreak() {
        breaks.append(points.count)
    }
    
    var path: Path {
        var path = Path()
        
        guard let firstPoint = points.first else { return path }
        path.move(to: firstPoint)
        for i in 1..<points.count {
            if breaks.contains(i) {
                path.move(to: points[i])
            } else {
                path.addLine(to: points[i])
            }
            
        }
        return path
    }
}

struct DrawShape: Shape {
    let drawingPath: DrawingPath
    
    func path(in rect: CGRect) -> Path {
        drawingPath.path
    }
}

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
