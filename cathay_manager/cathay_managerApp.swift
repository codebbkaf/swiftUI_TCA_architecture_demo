//
//  cathay_managerApp.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI
import ComposableArchitecture

@main
struct cathay_managerApp: App {
    
    let loginStore = Store(initialState: LoginReducer.State()) {
        LoginReducer()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthenticationView(loginStore: loginStore)
        }
    }
}
