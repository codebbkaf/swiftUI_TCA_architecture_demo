//
//  LoginState.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import Foundation

extension LoginReducer {
    struct State: Equatable {
        var email: String = ""
        var password: String = ""
        var loginStatus: Status = .loading
        
        enum Status: Equatable {
            case idle
            case loading
            case error
        }
    }
}
