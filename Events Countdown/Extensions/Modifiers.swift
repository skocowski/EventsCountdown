//
//  Modifiers.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 03/12/2022.
//

import Foundation
import SwiftUI

struct ElementShape: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.theme.backgroundElement)
            .cornerRadius(10)
    }
}
