//
//  LoginView.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    
    private struct Style {
        static let spacing: CGFloat = 20
    }
    
    private let store: StoreOf<LoginReducer>
    
    init(store: StoreOf<LoginReducer>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }, content: { store in
            GeometryReader(content: { geometry in
                HStack {
                    Spacer()
                    VStack(spacing: Style.spacing) {
                        Spacer()
                        HStack {
                            VStack (alignment:.leading, spacing: Style.spacing) {
                                Text("登入")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("請輸入您的帳號密碼")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.gray)
                            }
                            Spacer()
                        }
                        .padding(.vertical, Style.spacing)
                        VStack(alignment: .leading, spacing: Style.spacing) {
                            Text("帳號")
                                .foregroundStyle(Color.gray)
                            TextField("輸入帳號", text: store.binding(
                                get: \.email,
                                send: { .emailChanged($0) }
                            ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("密碼")
                                .foregroundStyle(Color.gray)
                            SecureField("輸入密碼", text: store.binding(
                                get: \.password,
                                send: { .passwordChanged($0) }
                            ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("忘記密碼?")
                                .foregroundStyle(CathayColor.primary)
                                .padding(.top, Style.spacing)
                            Button(action: {
                                store.send(.loginButtonTapped)
                            }) {
                                Text("登入")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(CathayColor.primary)
                                    .cornerRadius(10)
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: geometry.size.width * 0.8, maxHeight: .infinity)
                    Spacer()
                }
            })
        })
    }
}

#Preview {
    ContentView(loginStore: Store(initialState: LoginReducer.State()) {
        LoginReducer()
    })
}
