//
//  TestView.swift
//  TCAViewActionTest
//
//  Created by Jaehwi Kim on 9/10/24.
//

import SwiftUI
import ComposableArchitecture

struct TestView: View, ViewActionSending {
    let store: StoreOf<TestFeature>
    @ObservedObject var viewStore: ViewStoreOf<TestFeature>
    
    public init(store: StoreOf<TestFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    var body: some View {
        VStack {
            Button(
                action: {
                    send(.onButtonTapped)
                },
                label: {
                    Text("\(viewStore.count)")
                }
            )
        }
        .padding()
    }
}
