//
//  HabitsViewControllerDelegate.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 08.04.2023.
//

import Foundation

protocol HabitsViewControllerDelegate {
    func update()
    func update(with habit: Habit)
}

extension HabitsViewControllerDelegate {
    func update() {
        return
    }
    
    func update(with habit: Habit){
        return
    }
}
