//
//  IconsList.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 26/08/2022.
//

import SwiftUI

struct IconsListView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var icon: String
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 60))
    ]
    let icons = [
        "person.fill.badge.plus",
        "car.circle",
        "airplane",
        "pencil",
        "plus",
        "tram",
        "house",
        "moon",
        "sunset",
        "sunrise",
        "sun.min"
    ]
    
    var body: some View {
        
        ZStack {
            Color.theme.background.ignoresSafeArea()

            LazyVGrid(columns: columns) {
                ForEach(icons, id: \.self) { icon in
                    ZStack {
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.015, brightness: 0.866))
                        
                        Image(systemName: icon)
                            .font(.largeTitle)
                            .onTapGesture {
                                self.icon = icon
                                dismiss()
                            }
                    }
                }
            }
        }
    }
}

struct IconsListView_Previews: PreviewProvider {
    static var previews: some View {
        IconsListView(icon: .constant("star.fill"))
    }
}
