//
//  AlertConstants.swift
//  AlertModule
//
//  Created by 애니모비 on 2023/07/14.
//

import Foundation
import SwiftUI

extension Color {
    public static let COMMON_ALERT_THEME_BUTTON_COLOR = Color(red: 39/255, green: 99/255, blue: 186/255)
    public static let COMMON_ALERT_NONE_BUTTON_COLOR = Color(red: 1, green: 1, blue: 1)
    public static let COMMON_ALERT_NONE_BUTTON_TEXT_COLOR = Color(red: 34/255, green: 34/255, blue: 34/255)
    public static let COMMON_ALERT_NONE_BUTTON_BORDER_COLOR = Color(red: 204/255, green: 204/255, blue: 204/255)
}

enum AlertLayout {
    public static let BACKGROUND_FRAME_WIDTH_SIZE: CGFloat = 320
    public static let BACKGROUND_CORNER_RADIUS: CGFloat = 10
    public static let BUTTON_CORNER_RADIUS: CGFloat = 5
    public static let BUTTON_TEXT_SIZE: CGFloat = 16
    public static let MESSAGE_TEXT_SIZE: CGFloat = 16
}
