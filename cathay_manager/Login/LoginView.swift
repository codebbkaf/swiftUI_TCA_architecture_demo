//
//  LoginView.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    
    @State var isAccountValid: Bool = false

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
                            LoginTextField(title: "帳號", placeHolder: "輸入帳號", errorWording: "帳號格式不正確", pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}", textContentType: .emailAddress, isSecurity: false) { email, isValid in
                                isAccountValid = isValid
                                store.send(.emailChanged(email))
                            }
                            LoginTextField(title: "密碼", placeHolder: "輸入密碼", errorWording: "密碼格式不正確", pattern: "", textContentType: .password, isSecurity: true) { password, _ in
                                store.send(.passwordChanged(password))
                            }
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
                                    .background(isAccountValid && !store.state.password.isEmpty ? CathayColor.primary : Color.gray.opacity(0.5))
                                    .cornerRadius(10)
                            }
                            .disabled(!(isAccountValid && !store.state.password.isEmpty))
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
