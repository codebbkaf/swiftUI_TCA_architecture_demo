//
//  LoginReducer.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import ComposableArchitecture

@Reducer
struct LoginReducer {
    
    var body: some Reducer<State, Action> {
        Reduce {state, action in
            switch action {
            case .emailChanged(let email):
                state.email = email
                return .none
                
            case .passwordChanged(let password):
                state.password = password
                return .none
                
            case .loginButtonTapped:
                return .none
            }
        }
    }
}
