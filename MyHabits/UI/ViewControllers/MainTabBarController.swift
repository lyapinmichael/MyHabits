//
//  MainTabBarController.swift
//  MyHabits
//
//  Created by Ляпин Михаил on 17.03.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        
        let habitsNavController = setupNavigationController(root: HabitsViewController(), title: "Привычки", tabBarItem: "rectangle.grid.1x2.fill", largeTiles: true)
        
        let infoNavController = setupNavigationController(root: InfoViewController(), title: "Информация", tabBarItem: "info.circle.fill")
        
        viewControllers = [habitsNavController, infoNavController]

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "White")
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func setupNavigationController(root: UIViewController, title: String, tabBarItem: String, largeTiles: Bool = false) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: root)
        
        let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: tabBarItem), tag: 0)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "White")
        
        navigationController.tabBarItem = tabBarItem
        navigationController.navigationBar.prefersLargeTitles = largeTiles
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        return navigationController
        
    }
    
}
