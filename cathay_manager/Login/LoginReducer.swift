//
//  LoginReducer.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import Foundation
import ComposableArchitecture

@Reducer
struct LoginReducer {
    
    var body: some Reducer<State, Action> {
        Reduce {state, action in
            switch action {
            case .emailChanged(let email):
                state.email = email
                return .run(operation: { send in
                    await send(.statusChange(.idle))
                })
            case .passwordChanged(let password):
                state.password = password
                return .run(operation: { send in
                    await send(.statusChange(.idle))
                })
            case .statusChange(let status):
                state.loginStatus = status
                return .none
            case .loginButtonTapped:
                state.loginStatus = .loading
                return .run(
                    operation: { send in
                        do {
                            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                            await send(.statusChange(.error))
                        } catch {
                            print(error)
                        }
                        
                    }
                )
            }
        }
    }
}
