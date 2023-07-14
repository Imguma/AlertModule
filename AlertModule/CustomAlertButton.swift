//
//  CustomAlertButton.swift
//  AlertModule
//
//  Created by 애니모비 on 2023/07/14.
//

import SwiftUI

struct CustomAlertButton: View {
    let title: LocalizedStringKey                            // button title
    var onColor: Bool                                        // button color(on/off)
    var action: (() -> Void)? = nil                          // 일반 함수
    var task: (@Sendable () async throws -> Void)? = nil     // 비동기 함수
    
    var body: some View {
        Button {
            if action != nil {
                action?()
            }
            if task != nil {
                Task {
                    try await task?()
                }
            }
        } label: {
            Text(title)
                .frame(minWidth: 90, maxWidth: .infinity)
                .font(.system(size: AlertLayout.BUTTON_TEXT_SIZE, weight: onColor ? .regular : .bold))
                .foregroundColor(onColor ? Color.COMMON_ALERT_NONE_BUTTON_TEXT_COLOR : .white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: AlertLayout.BUTTON_CORNER_RADIUS)
                        .stroke(onColor ? Color.COMMON_ALERT_NONE_BUTTON_BORDER_COLOR : .clear, lineWidth: 1)
                )
        }
        .background(onColor ? Color.COMMON_ALERT_NONE_BUTTON_COLOR : Color.COMMON_ALERT_THEME_BUTTON_COLOR)
        .cornerRadius(AlertLayout.BUTTON_CORNER_RADIUS)
    }
}

//struct CustomAlertButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlertButton()
//    }
//}
