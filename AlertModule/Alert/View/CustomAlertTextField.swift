//
//  CustomAlertTextField.swift
//  AlertModule
//
//

import SwiftUI

public struct CustomAlertTextField: View {
    @Binding public var inputText: String      // 입력창 텍스트
    
    public init(inputText: Binding<String>) {
        self._inputText = inputText
    }
    
    public var body: some View {
        TextField("", text: $inputText)
            .font(.system(size: 18))
            .frame(minWidth: 90, maxWidth: .infinity)
            .background(AlertSetter.INPUT_BACKGROUND_COLOR)
            .overlay(
            RoundedRectangle(cornerRadius: 1)
                .stroke(AlertSetter.INPUT_BORDER_COLOR, lineWidth: 1))
            .onAppear {
                inputText = ""
            }
    }
}
