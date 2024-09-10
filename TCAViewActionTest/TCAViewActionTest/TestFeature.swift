//
//  TestFeature.swift
//  TCAViewActionTest
//
//  Created by Jaehwi Kim on 9/10/24.
//

import ComposableArchitecture

public struct TestFeature: Reducer {
    public struct State: Equatable {
        var count: Int = 0
    }
    
    public enum Action: Equatable, ViewAction {
        case onAppear
        case view(View)
        
        public enum View: Equatable {
            case onButtonTapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .view(.onButtonTapped):
                state.count += 1
                return .none
            }
        }
    }
}
