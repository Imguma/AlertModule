//
//  CustomAlert.swift
//  AlertModule
//
//  Created by 애니모비 on 2023/07/14.
//

import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String
    let dismissButton: CustomAlertButton?
    let primaryButton: CustomAlertButton?
    let secondaryButton: CustomAlertButton?
    
    @State private var opacity: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0
    @State private var scale: CGFloat = 0.001
    @State var contentSize: CGSize = .zero
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            dimView
            alertView
                .padding(EdgeInsets(top: 120, leading: 0, bottom: 120, trailing: 0))
        }
        .ignoresSafeArea()
    }
    
    private var alertView: some View {
        VStack(spacing: 20) {
            titleView
            messageView
            buttonsView
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        .frame(width: AlertLayout.BACKGROUND_FRAME_WIDTH_SIZE)
        .background(.white)
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
                Text(message)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                    .font(.system(size: AlertLayout.MESSAGE_TEXT_SIZE))
                    .foregroundColor(.black)
                    .lineSpacing(24 - UIFont.systemFont(ofSize: 16).lineHeight)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay(
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                contentSize = geo.size
                            }
                        }
                    )
            }
            .frame(maxHeight: contentSize.height) // dynamic text to height
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
                    dismiss()
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
                    dismiss()
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
                    dismiss()
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
                scale             = 1
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

//struct CustomAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlert()
//    }
//}
