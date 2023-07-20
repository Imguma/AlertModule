//
//  CustomAlertTextField.swift
//  AlertModule
//
//

import SwiftUI

struct CustomAlertTextField: View {
    @Binding var inputText: String   // 입력창 텍스트
    
    var body: some View {
        TextField("hint", text: $inputText)
            .font(.system(size: 15))
            .frame(minWidth: 90, maxWidth: .infinity)
            .background(AlertSetter.INPUT_BACKGROUND_COLOR)
            .overlay(
            RoundedRectangle(cornerRadius: 1)
                .stroke(AlertSetter.INPUT_BORDER_COLOR, lineWidth: 1))
    }
}
