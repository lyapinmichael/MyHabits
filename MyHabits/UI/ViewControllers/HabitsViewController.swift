//
//  TodayViewController.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 17.03.2023.
//

import UIKit

final class HabitsViewController: UIViewController {

    // MARK: - Private properties
    
    private lazy var plusBarButtonItem: UIBarButtonItem = {
        let plus = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(pushToAddHabitView)
        )
        
        plus.tintColor = UIColor(named: "Purple")
        return plus
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        title = "Сегодня"
        navigationItem.rightBarButtonItem = plusBarButtonItem
    }
    
    // MARK: - @Objc actions
    
    @objc private func pushToAddHabitView() {
        print("should push to next view controller")
    }

}
