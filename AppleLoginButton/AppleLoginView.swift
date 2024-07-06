//
//  ContentView.swift
//  AppleLoginButton
//
//  Created by Ismael Sabri Pérez on 3/7/24.
//

import SwiftUI
import AuthenticationServices

struct AppleLoginView: View {
    
    @EnvironmentObject var authenticationViewModel: AppleButtonViewModel
    @State var presentButton: Bool = false
    
    var body: some View {
        VStack {
            // This view will show the apple login button if the apple button is pressed
            InstructionsView(presentButton: $presentButton)
            
            // If the button is pressed, the following apple login button will be shown
            if(presentButton) {
                ButtonStylePickers(buttonLabel: $authenticationViewModel.selectedLabel, buttonStyle: $authenticationViewModel.selectedStyle)
                AppleButton(buttonLabel: $authenticationViewModel.selectedLabel, buttonStyle: $authenticationViewModel.selectedStyle)
            }
        }
        .padding(30)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 2)
        )
    }
}

#Preview {
    AppleLoginView()
        .environmentObject(AppleButtonViewModel())
}

// MARK: - AppleButton
struct AppleButton: View {
    
    @Binding var buttonLabel: SignInWithAppleButtonLabelWrapper
    @Binding var buttonStyle: SignInWithAppleButtonStyleWrapper
    
    var body: some View {
        // Sign in with Apple
        SignInWithAppleButton(buttonLabel.label) { request in
            // Here you can customize the request to send to Apple servers
            request.requestedScopes = [.fullName, .email]
            request.nonce = "randomNonce"
        } onCompletion: { result in
            switch result {
                case .success(let authorization):
                    // The success case provides you with an authorization that contains valuable auth info about the user authentication
                    print("Authorization: \(authorization)")
                case .failure(let error):
                    // When something goes wrong with the user authentication, this part of the code is executed
                    print("Error: \(error)")
            }
        }
        .frame(width: 280, height: 45)
        .signInWithAppleButtonStyle(buttonStyle.style)
        .id(UUID())
    }
}

// MARK: - Button mode
struct ButtonStylePickers: View {
    
    @Binding var buttonLabel: SignInWithAppleButtonLabelWrapper
    @Binding var buttonStyle: SignInWithAppleButtonStyleWrapper
    
    var body: some View {
        VStack(spacing: 20) {
            
            Picker("Button label", selection: $buttonLabel) {
                ForEach([SignInWithAppleButtonLabelWrapper.signIn,
                         SignInWithAppleButtonLabelWrapper.signUp,
                         SignInWithAppleButtonLabelWrapper.continue],
                        id: \.self) { label in
                    Text(label.description).tag(label)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Picker("Button Style", selection: $buttonStyle) {
                ForEach([SignInWithAppleButtonStyleWrapper.black,
                         SignInWithAppleButtonStyleWrapper.whiteOutline,
                         SignInWithAppleButtonStyleWrapper.white],
                        id: \.self) { style in
                    Text(style.description).tag(style)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom)

        }
    }
}

#Preview("Pickers") {
    
    @Previewable @State var buttonLabel: SignInWithAppleButtonLabelWrapper = .signIn
    @Previewable @State var buttonStyle: SignInWithAppleButtonStyleWrapper = .black
    
    ButtonStylePickers(buttonLabel: $buttonLabel, buttonStyle: $buttonStyle)
}




// MARK: - InstructionsView
/// This view will show the instructions and the button make the login Apple button visible.
struct InstructionsView: View {
    
    @Binding var presentButton: Bool
    
    var body: some View {
        VStack {
            Text("Want to implement the Apple sign in button?")
                .frame(width: 200)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.black, lineWidth: 2)
                )
            HStack {
                Button {
                    withAnimation {
                        presentButton.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: "apple.logo")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Press here")
                    }
                    .padding(.top, 20)
                }
            }
        }
        .padding()
    }
}

#Preview("InstructionsView") {
    
    @Previewable @State var presentButton: Bool = false
    
    InstructionsView(presentButton: $presentButton)
}
