//
//  LoginView.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    
    private let store: StoreOf<LoginReducer>
    
    init(store: StoreOf<LoginReducer>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }, content: { store in
            GeometryReader(content: { geometry in
                VStack {
                    Spacer()
                    VStack(spacing: 15) {
                        TextField("請輸入您的電子郵箱", text: store.binding(
                            get: \.email,
                            send: { .emailChanged($0) }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        
                        SecureField("密碼", text: store.binding(
                            get: \.password,
                            send: { .passwordChanged($0) }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        
                        Button(action: {
                            store.send(.loginButtonTapped)
                        }) {
                            Text("登入")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
        }
        )
    }}

#Preview {
    LoginView(store: Store(initialState: LoginReducer.State()) {
        LoginReducer()
    })
}
