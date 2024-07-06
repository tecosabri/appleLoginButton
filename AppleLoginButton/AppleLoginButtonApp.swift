//
//  AppleLoginButtonApp.swift
//  AppleLoginButton
//
//  Created by Ismael Sabri Pérez on 3/7/24.
//

import SwiftUI

@main
struct AppleLoginButtonApp: App {
    var body: some Scene {
        WindowGroup {
            AppleLoginView()
                .environmentObject(AppleButtonViewModel())
        }
    }
}
