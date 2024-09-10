//
//  TCAViewActionTestApp.swift
//  TCAViewActionTest
//
//  Created by Jaehwi Kim on 9/10/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAViewActionTestApp: App {
    var body: some Scene {
        WindowGroup {
            TestView(
                store: Store(initialState: TestFeature.State()) {
                    TestFeature()
                        ._printChanges()
                }
            )
        }
    }
}
