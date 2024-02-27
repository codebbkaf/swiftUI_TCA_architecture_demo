//
//  LoginAction.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import Foundation

extension LoginReducer {
    enum Action: Equatable {
        case emailChanged(String)
        case passwordChanged(String)
        case loginButtonTapped
    }
}
