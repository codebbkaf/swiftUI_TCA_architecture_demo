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
                                Text(NSLocalizedString("login__page_login_title", comment: ""))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text(NSLocalizedString("login__page_login_hint", comment: ""))
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.gray)
                            }
                            Spacer()
                        }
                        .padding(.vertical, Style.spacing)
                        if store.state.loginStatus == .error {
                            InfoBannerView(message: NSLocalizedString("login__page_account_or_password_error", comment: ""))
                        }
                        VStack(alignment: .leading, spacing: Style.spacing) {
                            LoginTextField(title: NSLocalizedString("login__page_account_title", comment: ""), placeHolder: NSLocalizedString("login__page_account_placeholder", comment: ""), errorWording: NSLocalizedString("login__page_account_format_error", comment: ""), pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}", keyboardType: .emailAddress, isSecurity: false) { email, isValid in
                                isAccountValid = isValid
                                store.send(.emailChanged(email))
                            }
                            LoginTextField(title: NSLocalizedString("login__page_password_title", comment: ""), placeHolder: NSLocalizedString("login__page_password_placeholder", comment: ""), errorWording: "", pattern: "", keyboardType: .default, isSecurity: true) { password, _ in
                                store.send(.passwordChanged(password))
                            }
                            Text(NSLocalizedString("login__page_forget_password", comment: ""))
                                .foregroundStyle(CathayColor.primary)
                                .padding(.top, Style.spacing)
                            Button(action: {
                                if store.state.loginStatus != .loading {
                                    store.send(.loginButtonTapped)
                                }
                            }) {
                                if store.state.loginStatus == .loading {
                                    HStack(alignment: .center) {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                        Spacer()
                                    }
                                }
                                if store.state.loginStatus != .loading {
                                    Text(NSLocalizedString("login__page_login_button_title", comment: ""))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(isAccountValid && !store.state.password.isEmpty ? CathayColor.primary : Color.gray.opacity(0.5))
                                        .cornerRadius(10)
                                }
                            }
                            .disabled(!(isAccountValid && !store.state.password.isEmpty && store.state.loginStatus != .loading))
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
    AuthenticationView(loginStore: Store(initialState: LoginReducer.State()) {
        LoginReducer()
    })
}
