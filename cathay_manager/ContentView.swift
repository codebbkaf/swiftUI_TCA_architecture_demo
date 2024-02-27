//
//  ContentView.swift
//  cathay_manager
//
//  Created by 曾華宇 on 2024/2/27.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        GeometryReader(content: { geometry in
            HStack {
                WelcomeView()
                    .frame(width: geometry.size.width * 0.4)
                Divider()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }
}

#Preview {
    ContentView()
}
