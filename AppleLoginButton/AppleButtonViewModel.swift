//
//  AuthenticationViewModel.swift
//  AppleLoginButton
//
//  Created by Ismael Sabri Pérez on 5/7/24.
//

import SwiftUI
import AuthenticationServices


class AppleButtonViewModel: ObservableObject {
    
    @Published var selectedLabel: SignInWithAppleButtonLabelWrapper = .signIn
    @Published var selectedStyle: SignInWithAppleButtonStyleWrapper = .black
    
    
}

