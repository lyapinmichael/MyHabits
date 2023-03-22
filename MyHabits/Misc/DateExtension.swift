//
//  DateExtension.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 21.03.2023.
//

import Foundation

extension Date {
    func isToday (_ date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        return dateComponents == selfComponents
    }
    
    func isYesterday (_ date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let selfComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        
        if dateComponents.year == selfComponents.year,
           dateComponents.month == selfComponents.month,
           dateComponents.day == selfComponents.day! - 1 {
            return true
        } else {return false}
           
    }
}
