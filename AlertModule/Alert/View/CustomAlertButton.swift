//
//  CustomAlertButton.swift
//  AlertModule
//
//

import SwiftUI

public struct CustomAlertButton: View {
    public let title: LocalizedStringKey                            // button title
    public var onColor: Bool                                        // button color(on/off)
    public var action: (() -> Void)? = nil                          // 일반 함수
    public var task: (@Sendable () async throws -> Void)? = nil     // 비동기 함수
    
    public init(title: LocalizedStringKey, onColor: Bool, action: ( () -> Void)? = nil, task: (@Sendable () async throws -> Void)? = nil) {
        self.title = title
        self.onColor = onColor
        self.action = action
        self.task = task
    }
    
    public var body: some View {
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
                .foregroundColor(!onColor ? AlertSetter.CONFIRM_BUTTON_TEXT_COLOR : AlertSetter.CANCEL_BUTTON_TEXT_COLOR)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: AlertLayout.BUTTON_CORNER_RADIUS)
                        .stroke(!onColor ? .clear : AlertSetter.CANCEL_BUTTON_BORDER_COLOR, lineWidth: 1)
                )
        }
        .background(!onColor ? AlertSetter.CONFIRM_BUTTON_BACKGROUND_COLOR : AlertSetter.CANCEL_BUTTON_BACKGROUND_COLOR)
        .cornerRadius(AlertLayout.BUTTON_CORNER_RADIUS)
    }
}
