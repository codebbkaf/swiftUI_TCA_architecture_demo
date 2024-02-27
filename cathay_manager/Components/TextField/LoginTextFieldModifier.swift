//
//  LoginTextFieldModifier.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI

struct LoginTextFieldModifier: ViewModifier {
    var isValid: Bool
    var keyboardType: UIKeyboardType
    
    func body(content: Content) -> some View {
        content
            .keyboardType(keyboardType)
            .textFieldStyle(PlainTextFieldStyle())
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isValid ? Color.gray.opacity(0.3) : Color.red, lineWidth: 1)
            )
    }
}

extension View {
    func validationStyle(isValid: Bool, keyboardType: UIKeyboardType) -> some View {
        self.modifier(LoginTextFieldModifier(isValid: isValid, keyboardType: keyboardType))
    }
}
