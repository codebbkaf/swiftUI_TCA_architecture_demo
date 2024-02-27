//
//  InfoBannerView.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI

struct InfoBannerView: View {
    let message: String

    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .foregroundColor(.white)
            Text(message)
                .foregroundColor(.white)
                .font(.callout)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
        .background(Color.red)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

#Preview {
    InfoBannerView(message: "帳號或密碼不正確 ，請重新確認或以「忘記密碼？」登入")
}
