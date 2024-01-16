//
//  TabBarController.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 15.01.2024.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    let randomViewController = RandomJokeViewController()
    let listViewController = JokeListViewController()
    let groupViewController = CategoryJokeViewController()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupControllers()
        }
        
    func setupControllers() {
        
        randomViewController.tabBarItem.title = "Random Joke"
        randomViewController.tabBarItem.image = UIImage(systemName: "quote.bubble")
        randomViewController.navigationItem.title = "Random Joke"
        
        listViewController.tabBarItem.title = "Joke List"
        listViewController.tabBarItem.image = UIImage(systemName: "list.clipboard")
        listViewController.navigationItem.title = "Joke List"
        
        groupViewController.tabBarItem.title = "Category"
        groupViewController.tabBarItem.image = UIImage(systemName: "list.bullet.below.rectangle")
        groupViewController.navigationItem.title = "Category"
        
        let randomNavController = UINavigationController(rootViewController: randomViewController)
        let listNavController = UINavigationController(rootViewController: listViewController)
        let groupNavController = UINavigationController(rootViewController: groupViewController)
        
        viewControllers = [randomNavController, listNavController, groupNavController]
    }
    
}
