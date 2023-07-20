//
//  CustomAlertModifier.swift
//  AlertModule
//
//  Created by 애니모비 on 2023/07/14.
//

import SwiftUI

struct CustomAlertModifier {
    @Binding private var isPresented: Bool

    private let title: String
    private let message: String
    private let inputTextField: CustomAlertTextField?
    private let dismissButton: CustomAlertButton?
    private let primaryButton: CustomAlertButton?
    private let secondaryButton: CustomAlertButton?
}


extension CustomAlertModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                CustomAlert(title: title, message: message, inputTextField: inputTextField, dismissButton: dismissButton, primaryButton: primaryButton, secondaryButton: secondaryButton)
                    .background(BackgroundCleanerView())
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}

// alert layer 뒷 배경 투명 설정
struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

extension CustomAlertModifier {
    init(title: String = "", message: String = "", dismissButton: CustomAlertButton, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.dismissButton = dismissButton
        
        self.inputTextField = nil
        self.primaryButton = nil
        self.secondaryButton = nil
    
        _isPresented = isPresented
    }

    init(title: String = "", message: String = "", primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        
        self.inputTextField = nil
        self.dismissButton = nil
    
        _isPresented = isPresented
    }
    
    init(title: String = "", message: String = "", inputTextField: CustomAlertTextField, primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.inputTextField = inputTextField
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        
        self.dismissButton = nil
    
        _isPresented = isPresented
    }
}
