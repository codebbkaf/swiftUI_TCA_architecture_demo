//
//  ContentView.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI
import ComposableArchitecture

struct AuthenticationView: View {
    
    private let loginStore: StoreOf<LoginReducer>
    
    init(loginStore: StoreOf<LoginReducer>) {
        self.loginStore = loginStore
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            HStack {
                WelcomeView()
                    .frame(width: geometry.size.width * 0.4)
                Divider()
                LoginView(store: loginStore)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }
}

#Preview {
    AuthenticationView(loginStore: Store(initialState: LoginReducer.State()) {
        LoginReducer()
    })
}
