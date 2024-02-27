//
//  WelcomeView.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI

struct WelcomeView: View {
    
    private struct Style {
        static let spacing: CGFloat = 20
        static let contentPadding = EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Style.spacing) {
                Image("cathay_mark_logo")
                    .frame(height: 50)
                Spacer()
                Text("嗨！歡迎回來")
                    .font(.title)
                    .fontWeight(.bold)
                HStack(alignment: .center) {
                    Image("welcome")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
            }
            .padding(Style.contentPadding)
            Spacer()
        }
    }
}

#Preview {
    WelcomeView()
}
