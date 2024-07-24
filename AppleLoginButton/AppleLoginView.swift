//
//  ContentView.swift
//  AppleLoginButton
//
//  Created by Ismael Sabri Pérez on 3/7/24.
//

import SwiftUI
import AuthenticationServices

struct AppleLoginView: View {
    
    @State var presentButton: Bool = false
    @EnvironmentObject var viewModel: AppleButtonViewModel
    
    var body: some View {
        
        VStack {
            // This view will show the apple login button if the apple button is pressed
            InstructionsView(presentButton: $presentButton)
            
            // If the button is pressed, the following apple login button will be shown with some pickers to select the button's UI
            if(presentButton) {
                ButtonStylePickers()
                AppleButton()
            }
        }
        .padding(30)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 2)
        )
        .alert("Authenticated!", isPresented: $viewModel.showPopUp) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    AppleLoginView()
        .environmentObject(AppleButtonViewModel())
}

// MARK: - AppleButton
/// AppleButton is a view that contains the Apple sign in button with the selected label and style of the AppleButtonViewModel.
struct AppleButton: View {
    
    @EnvironmentObject var appleButtonViewModel: AppleButtonViewModel
    
    var body: some View {
        // Sign in with Apple
        SignInWithAppleButton(appleButtonViewModel.selectedLabel.label) { request in
            // Here you can customize the request to send to Apple servers
            request.requestedScopes = [.fullName, .email]
            request.nonce = "randomNonce"
        } onCompletion: { result in
            switch result {
                case .success(let authorization):
                    // The success case provides you with an authorization that contains valuable auth info about the user authentication
                    print("Authorization: \(authorization)")
                    appleButtonViewModel.showPopUp = true
                case .failure(let error):
                    // When something goes wrong with the user authentication, this part of the code is executed
                    print("Error: \(error)")
            }
        }
        .frame(width: 280, height: 45) // Follow the Apple guidelines for the button size
        .signInWithAppleButtonStyle(appleButtonViewModel.selectedStyle.style)
        .id("\(appleButtonViewModel.selectedLabel)-\(appleButtonViewModel.selectedStyle)") // The Label and Style are not suitable for UI changes so it is mandatory to force a re-render of the button when the properties change
    }
}

// MARK: - Button mode
struct ButtonStylePickers: View {
    
    @EnvironmentObject var appleButtonViewModel: AppleButtonViewModel

    var body: some View {
        VStack(spacing: 20) {
            
            Picker("Button label", selection: $appleButtonViewModel.selectedLabel) {
                ForEach(appleButtonViewModel.appleButtonLabels,
                        id: \.self) { label in
                    Text(label.id).tag(label)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Picker("Button Style", selection: $appleButtonViewModel.selectedStyle) {
                ForEach(appleButtonViewModel.appleButtonStyles,
                        id: \.self) { style in
                    Text(style.id).tag(style)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom)

        }
    }
}

#Preview("Pickers") {
    ButtonStylePickers()
        .environmentObject(AppleButtonViewModel())
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
