//
//  Color.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 28/11/2022.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
//    let backgroundElement = Color("ElementBackground")
    let backgroundElement = Color(.systemFill)
    let whiteFont = Color("WhiteFont")
}






