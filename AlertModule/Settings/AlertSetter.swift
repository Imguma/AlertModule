//
//  AlertSetter.swift
//  AlertModule
//
//  Created by 애니모비 on 2023/07/20.
//

import Foundation
import SwiftUI

extension Color {
    init(hexString: String, opacity: Double = 1.0) {
        let hex: Int = Int(hexString, radix: 16)!
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

public struct AlertSetter {
    public static var CONFIRM_BUTTON_BACKGROUND_COLOR: Color = Color(hexString: "2763ba")
    public static var CONFIRM_BUTTON_TEXT_COLOR: Color = Color(hexString: "ffffff")
    public static var CONFIRM_BUTTON_BORDER_COLOR: Color = Color(hexString: "")
    
    public static var CANCEL_BUTTON_BACKGROUND_COLOR: Color = Color(hexString: "FF0000")
    public static var CANCEL_BUTTON_TEXT_COLOR: Color = Color(hexString: "FFFFFF")
    public static var CANCEL_BUTTON_BORDER_COLOR: Color = Color(hexString: "cccccc")
    
    public static var INPUT_BACKGROUND_COLOR: Color = Color(hexString: "EDEDED")
    public static var INPUT_BORDER_COLOR: Color = Color(hexString: "dadada")
}

