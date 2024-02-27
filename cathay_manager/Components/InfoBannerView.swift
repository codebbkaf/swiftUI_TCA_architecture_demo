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
    InfoBannerView(message: NSLocalizedString("login__page_account_or_password_error", comment: ""))
}
