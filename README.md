# Apple login button

![appleButton.gif](Apple%20login%20button%20f12c153be60f476abd8588145522531a/appleButton.gif)

# Table of Contents
- [Prerequisites](#prerequisites)
- [Button Functionality](#button-functionality)
- [Button Appearance](#button-appearance)
  - [Button Types](#button-types)
  - [Light and Dark Modes](#light-and-dark-modes)
- [Resources](#resources)


<a name="prerequisites"></a>
# Prerequisites

To implement the Apple Sign In button, an active developer account is necessary. Without this account, when attempting to sign in, we will receive the following error:

![Captura de pantalla 2024-07-03 a las 18.22.03.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/Captura_de_pantalla_2024-07-03_a_las_18.22.03.png)

Additionally, we'll need the following import:

```swift
import AuthenticationServices
```

<a name="button-functionality"></a>
# Button Functionality

The initial structure of the button is as follows:

```swift
SignInWithAppleButton() { request in
  
} onCompletion: { result in
   
}
```

When the button is pressed, a request is made to Apple's servers in which we can configure the data we want to be returned in the response.

```swift
SignInWithAppleButton() { request in
    request.requestedScopes = [.fullName, .email]
    request.nonce = "nonce"
} onCompletion: { result in
   
}
```

In this case, we're asking for the user's full name and email in the response. We also specify that we want a functional nonce field in the returned token (the nonce is covered in the tutorial dedicated to Apple token nonce).

Once the request is made, a sheet is displayed on the device screen allowing us to sign in with our Apple account. The result of this sign-in reaches us in the onCompletion closure, which can be either successful or an error.

```swift
SignInWithAppleButton() { request in
    request.requestedScopes = [.fullName, .email]
    request.nonce = "nonce"
} onCompletion: { result in
    switch result {
    case .success:
        print("Success")
    case .failure(let error):
        print("Error: \(error)")
    }
}
```

If there's an error during the process, the result prints the following log to the screen, similar to what we obtained earlier but with a different identifier.

![Captura de pantalla 2024-07-05 a las 13.09.12.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/Captura_de_pantalla_2024-07-05_a_las_13.09.12.png)

However, if the result is successful, what arrives in the result is an object of type ASAuthorization, an authorization that guarantees the user has been correctly identified. Although this authorization should be processed further to continue with the authentication process, at this point we know that the user has successfully communicated with Apple's servers and has a valid active account.

```swift
SignInWithAppleButton() { request in
    request.requestedScopes = [.fullName, .email]
    request.nonce = "nonce"
} onCompletion: { result in
    switch result {
    case .success(let authorization):
        print("Authorization: \(authorization)") // Valid icloud account
    case .failure(let error):
        print("Error: \(error)")
    }
}
```

<a name="button-appearance"></a>
# Button Appearance

First of all, Apple recommends using one of the natively offered button styles which has the following advantages:

- An Apple-approved style.
- The button content will adapt to its size.
- The text will automatically translate depending on the device's language.
- Light and dark mode.
- Modification of the corner radius to match the app's UI.

<a name="button-types"></a>
## Button Types

The type of button displayed depends on the first parameter of the button, which by default is "signIn". To change it, we just need to specify the type like this:

```swift
SignInWithAppleButton(.continue) { request in

} onCompletion: { result in

}
```

![Captura de pantalla 2024-07-05 a las 17.14.33.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/Captura_de_pantalla_2024-07-05_a_las_17.14.33.png)

```swift
SignInWithAppleButton(.signUp) { request in

} onCompletion: { result in

}
```

![Captura de pantalla 2024-07-05 a las 17.14.22.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/Captura_de_pantalla_2024-07-05_a_las_17.14.22.png)

```swift
SignInWithAppleButton(.continue) { request in

} onCompletion: { result in

}
```

![Captura de pantalla 2024-07-05 a las 17.14.22.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/Captura_de_pantalla_2024-07-05_a_las_17.14.22.png)

<a name="light-and-dark-modes"></a>
## Light and Dark Modes

The button mode can be dark, light, or light with a black stroke delimiting it on the outside. Unlike the type, the mode is obtained through the following button modifiers:

```swift
.signInWithAppleButtonStyle(.whiteOutline)
.signInWithAppleButtonStyle(.black)
.signInWithAppleButtonStyle(.white)
```

![apple-id-outline-yes@2x.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/720a5769-7852-4a69-9b4d-7252e7f35a25.png)

![apple-id-black-yes@2x.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/dc77c6b1-76e3-43fd-9022-bc0642138109.png)

![apple-id-white-yes@2x.png](Apple%20login%20button%20f12c153be60f476abd8588145522531a/854eecd3-9d55-4d87-be42-17a8d5702732.png)

<a name="resources"></a>
# Resources

[https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple](https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple)

[https://appleid.apple.com/signinwithapple/button](https://appleid.apple.com/signinwithapple/button)


