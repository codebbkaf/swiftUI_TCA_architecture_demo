//
//  cathay_managerTests.swift
//  cathay_managerTests
//
//  Created by 曾華宇 on 2024/2/27.
//

import XCTest
@testable import cathay_manager
import ComposableArchitecture

final class UnitTexts: XCTestCase {

    @MainActor
    func testLoginFlow() async {
        let store = TestStore(initialState: LoginReducer.State()) {
            LoginReducer()
        }
        
        await store.send(.emailChanged("test@example.com")) {
            $0.email = "test@example.com"
        }
        await store.receive(.statusChange(.idle))
        await store.send(.passwordChanged("password123")) {
            $0.password = "password123"
        }
        await store.send(.loginButtonTapped) {
            $0.loginStatus = .loading
        }
        await store.receive(.statusChange(.error), timeout: Duration.seconds(2)) {
            $0.loginStatus = .error
        }
        await store.send(.passwordChanged("password456")) {
            $0.password = "password456"
        }
        await store.receive(.statusChange(.idle)) {
            $0.loginStatus = .idle
        }
    }
}
