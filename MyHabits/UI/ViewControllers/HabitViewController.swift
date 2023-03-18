//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 17.03.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    
    }
    
    // MARK:  - Private methods
    
    private func setup() {
        view.backgroundColor = UIColor(named: "PickedBackgroundWhite")
        
    }

}
