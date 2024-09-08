//
//  ViewController.swift
//  SpringBootDemo
//
//  Created by Sarthak Agrawal on 06/09/24.
//

import UIKit

class TabBarVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }
    
    func setupTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeVC())
        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(systemName: "house") // Optional: Add an image
        
        let employeeVC = UINavigationController(rootViewController: EmployeeListVC())
        employeeVC.tabBarItem.title = "Employee"
        employeeVC.tabBarItem.image = UIImage(systemName: "person.3") // Optional: Add an image
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeVC, employeeVC]
        
        // Set the tabBarController as the root view controller
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}

