//
//  Events_CountdownApp.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 26/08/2022.
//

import SwiftUI

@main
struct Events_CountdownApp: App {
    
    @StateObject var vm = EventsCountdownViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
        }
    }
}
