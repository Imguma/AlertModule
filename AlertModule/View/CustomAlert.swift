//
//  CustomAlert.swift
//  AlertModule
//
//  Created by 애니모비 on 2023/07/14.
//

import SwiftUI

struct CustomAlert: View, KeyboardReadable {
    let title: String
    let message: String
    let inputTextField: CustomAlertTextField?
    let dismissButton: CustomAlertButton?
    let primaryButton: CustomAlertButton?
    let secondaryButton: CustomAlertButton?

    @State private var opacity: CGFloat = 0              // 불투명도
    @State private var backgroundOpacity: CGFloat = 0    // 배경 불투명도
    @State private var contentSize: CGSize = .zero       // message view size
    @State private var isKeyboardUp: Bool = false        // 키보드 올라옴 감지
    
    // iOS 13.0–17.0 Deprecated
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            dimView
            alertView
                .padding()
                .padding(EdgeInsets(top: 120, leading: 0, bottom: isKeyboardUp ? 200 : 120, trailing: 0))
        }
        .ignoresSafeArea()
        .onReceive(keyboardPublisher) { visible in
            isKeyboardUp = visible  // 키보드 올라옴 감지
        }
    }
    
    private var alertView: some View {
        VStack(spacing: 20) {
            titleView
            messageView
            buttonsView
        }
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
        .frame(width: AlertLayout.BACKGROUND_FRAME_WIDTH_SIZE)
        .background(Color.white)
        .cornerRadius(AlertLayout.BACKGROUND_CORNER_RADIUS)
        .shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: 12)
    }
    
    @ViewBuilder
    private var titleView: some View {
        if !title.isEmpty {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .lineSpacing(24 - UIFont.systemFont(ofSize: 18, weight: .bold).lineHeight)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    private var messageView: some View {
        if !message.isEmpty {
            ScrollView {
                VStack {
                    Text(message)
                        .font(.system(size: AlertLayout.MESSAGE_TEXT_SIZE))
                        .foregroundColor(.black)
                        .lineSpacing(24 - UIFont.systemFont(ofSize: 16).lineHeight)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                    inputTextView
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .overlay(
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            contentSize = geo.size
                        }
                    }
                )
            }
            .frame(maxHeight: contentSize.height) // height according to flexible text
        }
    }
    
    @ViewBuilder
    private var inputTextView: some View {
        VStack {
            if inputTextField != nil {
                inputTextField
            }
        }
    }
    
    private var buttonsView: some View {
        HStack(spacing: 10) {
            if dismissButton != nil {
                dismissButtonView
                
            } else if primaryButton != nil, secondaryButton != nil {
                secondaryButtonView
                primaryButtonView
            }
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 30))
    }
    
    @ViewBuilder
    private var primaryButtonView: some View {
        if let button = primaryButton {
            CustomAlertButton(title: button.title, onColor: button.onColor) {
                animate(isShown: false) {
                    presentationMode.wrappedValue.dismiss()
                }
                
                if button.action != nil {
                    button.action?()
                }
                
                if button.task != nil {
                    Task {
                        try await button.task?()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var secondaryButtonView: some View {
        if let button = secondaryButton {
            CustomAlertButton(title: button.title, onColor: button.onColor) {
                animate(isShown: false) {
                    presentationMode.wrappedValue.dismiss()
                }
            
                if button.action != nil {
                    button.action?()
                }
                
                if button.task != nil {
                    Task {
                        try await button.task?()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var dismissButtonView: some View {
        if let button = dismissButton {
            CustomAlertButton(title: button.title, onColor: button.onColor) {
                animate(isShown: false) {
                    presentationMode.wrappedValue.dismiss()
                }
                
                if button.action != nil {
                    button.action?()
                }
                
                if button.task != nil {
                    Task {
                        try await button.task?()
                    }
                }
            }
        }
    }
    
    private var dimView: some View {
        Color.gray
            .opacity(0.8)
    }
    
    // alert animation 함수 (on/off 가능)
    private func animate(isShown: Bool, completion: (() -> Void)? = nil) {
        switch isShown {
        case true:
            opacity = 1
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0).delay(0.5)) {
                backgroundOpacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion?()
            }
            
        case false:
            withAnimation(.easeOut(duration: 0.2)) {
                backgroundOpacity = 0
                opacity           = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion?()
            }
        }
    }
}
