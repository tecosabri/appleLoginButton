//
//  AuthenticationViewModel.swift
//  AppleLoginButton
//
//  Created by Ismael Sabri Pérez on 5/7/24.
//

import SwiftUI
import AuthenticationServices


class AppleButtonViewModel: ObservableObject {
    
    @Published var selectedLabel: SignInWithAppleButtonLabelWrapper = SignInWithAppleButtonLabelWrapper(label: .signIn, id: "signIn")
    @Published var selectedStyle: SignInWithAppleButtonStyleWrapper = SignInWithAppleButtonStyleWrapper(style: .black, id: "black")
    @Published var showPopUp: Bool = false
    
    let appleButtonLabels: [SignInWithAppleButtonLabelWrapper] =
        [SignInWithAppleButtonLabelWrapper(label: .signIn, id: "signIn"),
        SignInWithAppleButtonLabelWrapper(label: .continue, id: "continue"),
        SignInWithAppleButtonLabelWrapper(label: .signUp, id: "signUp")]
    
 
    let appleButtonStyles: [SignInWithAppleButtonStyleWrapper] =
    [SignInWithAppleButtonStyleWrapper(style: .black, id: "black"),
         SignInWithAppleButtonStyleWrapper(style: .white, id: "white"),
         SignInWithAppleButtonStyleWrapper(style: .whiteOutline, id: "whiteOutline")]
}

struct SignInWithAppleButtonLabelWrapper: Hashable {
    
    let label: SignInWithAppleButton.Label
    let id: String
    
    static func == (lhs: SignInWithAppleButtonLabelWrapper, rhs: SignInWithAppleButtonLabelWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SignInWithAppleButtonStyleWrapper: Hashable {

    let style: SignInWithAppleButton.Style
    let id: String
    
    static func == (lhs: SignInWithAppleButtonStyleWrapper, rhs: SignInWithAppleButtonStyleWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


