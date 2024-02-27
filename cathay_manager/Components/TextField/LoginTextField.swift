//
//  LoginTextField.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI

struct LoginTextField: View {
    
    private struct Style {
        static let spacing: CGFloat = 20
    }
    
    @State private var content: String = ""
    @State private var isSecurity: Bool
    @State private var showEyeButton: Bool
    @State var isValid: Bool = true
    
    private let title: String
    private let placeHolder: String
    private let errorWording: String
    private let pattern: String
    private let keyboardType: UIKeyboardType
    private let onChange: ((String, Bool) -> Void)?
    private let maxLength = 32
    
    init(title: String, placeHolder: String, errorWording: String, pattern: String, keyboardType: UIKeyboardType, isSecurity: Bool, onChange: ((String, Bool) -> Void)?) {
        self.title = title
        self.placeHolder = placeHolder
        self.errorWording = errorWording
        self.pattern = pattern
        self.keyboardType = keyboardType
        self.isSecurity = isSecurity
        self.showEyeButton = isSecurity
        self.onChange = onChange
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(Color.gray)
            ZStack(alignment: .trailing) {
                if showEyeButton {
                    SecureField(placeHolder, text: $content)
                        .onChange(of: content) { newValue in
                            let contentWithMax = String(newValue.prefix(maxLength))
                            if content.count > maxLength {
                                content = contentWithMax
                            }
                            isValid = validate(contentWithMax)
                            onChange?(contentWithMax, isValid)
                        }
                        .validationStyle(isValid: isValid, keyboardType: keyboardType)
                }
                if !showEyeButton {
                    TextField(placeHolder, text: $content)
                        .onChange(of: content) { newValue in
                            let contentWithMax = String(newValue.prefix(maxLength))
                            if content.count > maxLength {
                                content = contentWithMax
                            }
                            isValid = validate(contentWithMax)
                            onChange?(contentWithMax, isValid)
                        }
                        .validationStyle(isValid: isValid, keyboardType: keyboardType)
                }
                if isSecurity {
                    Button(action: {
                        showEyeButton.toggle()
                    }) {
                        Image(systemName: showEyeButton ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, Style.spacing)
                }
            }
            if !isValid {
                Text(errorWording)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
    
    private func validate(_ content: String) -> Bool {
        if pattern.isEmpty {
            return true
        }
        let pattern = pattern
        let predicate = NSPredicate(format:"SELF MATCHES %@", pattern)
        return predicate.evaluate(with: content)
    }
}

struct LoginTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginTextField(title: "帳號", placeHolder: "輸入帳號", errorWording: "帳號格式不正確", pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}", keyboardType: .emailAddress, isSecurity: false, onChange: nil)
    }
}
