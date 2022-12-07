//
//  Date.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 03/12/2022.
//

import Foundation

extension Date {

    func allDayDate() -> Date {

        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
}
