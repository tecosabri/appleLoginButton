//
//  AppleButtonWrappers.swift
//  AppleLoginButton
//
//  Created by Ismael Sabri Pérez on 6/7/24.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonLabelWrapper: Hashable {
    var label: SignInWithAppleButton.Label
    private let id: String

    static let signIn = SignInWithAppleButtonLabelWrapper(label: .signIn, id: "signIn")
    static let `continue` = SignInWithAppleButtonLabelWrapper(label: .continue, id: "continue")
    static let signUp = SignInWithAppleButtonLabelWrapper(label: .signUp, id: "signUp")

    static func == (lhs: SignInWithAppleButtonLabelWrapper, rhs: SignInWithAppleButtonLabelWrapper) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var description: String {
        return id.capitalized
    }
}

struct SignInWithAppleButtonStyleWrapper: Hashable {
    var style: SignInWithAppleButton.Style
    private let id: String

    static let black = SignInWithAppleButtonStyleWrapper(style: .black, id: "black")
    static let white = SignInWithAppleButtonStyleWrapper(style: .white, id: "white")
    static let whiteOutline = SignInWithAppleButtonStyleWrapper(style: .whiteOutline, id: "whiteOutline")

    static func == (lhs: SignInWithAppleButtonStyleWrapper, rhs: SignInWithAppleButtonStyleWrapper) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var description: String {
        return id.capitalized
    }
}
