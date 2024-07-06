//
//  ViewExtension.swift
//  LoginViews
//
//  Created by Ismael Sabri Pérez on 27/6/24.
//

import SwiftUI

extension View {
    /// This function adds a conditional modifier to the view
    /// - Parameters:
    /// - condition: A boolean value that determines whether the modifier should be applied or not
    /// - transform: The modifier to be applied
    /// - Returns: A view with the conditional modifier
    @ViewBuilder func `if` <Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self // The closure has to return some View but the 'if' property is itself a view 
        }
    }
}

