//
//  CustomAlertModifier.swift
//  AlertModule
//
//

import SwiftUI

public struct CustomAlertModifier {
    @Binding public var isPresented: Bool

    public let title: String
    public let message: String
    public let inputTextField: CustomAlertTextField?
    public let dismissButton: CustomAlertButton?
    public let primaryButton: CustomAlertButton?
    public let secondaryButton: CustomAlertButton?
}


extension CustomAlertModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                CustomAlert(title: title, message: message, inputTextField: inputTextField, dismissButton: dismissButton, primaryButton: primaryButton, secondaryButton: secondaryButton)
                    .background(BackgroundCleanerView())
            }
            .transaction { transaction in
                // animation 비활성화
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

// custom alert 생성자
public extension CustomAlertModifier {
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
