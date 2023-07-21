//
//  Extensions.swift
//  AlertModule
//
//

import SwiftUI

public extension View {
    // default alert with one button
    func customAlert(isPresented: Binding<Bool>, title: String = "", message: String = "", dismissButton: CustomAlertButton = CustomAlertButton(title: "확인", onColor: false)) -> some View {
        let title   = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        
        return modifier(CustomAlertModifier(title: title, message: message, dismissButton: dismissButton, isPresented: isPresented))
    }
    
    // default alert with two buttons
    func customAlert(isPresented: Binding<Bool>, title: String = "", message: String = "", primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton) -> some View {
        let title   = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        
        return modifier(CustomAlertModifier(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton, isPresented: isPresented))
    }
    
    // input alert with two buttons
    func customAlert(isPresented: Binding<Bool>, title: String = "", message: String = "", inputTextField: CustomAlertTextField, primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton) -> some View {
        let title   = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        
        return modifier(CustomAlertModifier(title: title, message: message, inputTextField: inputTextField, primaryButton: primaryButton, secondaryButton: secondaryButton, isPresented: isPresented))
    }

    // toast
    func customToast<T: View>(overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay(show: show, overlayView: overlayView))
    }
}
