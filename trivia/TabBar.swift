//
//  TabBar.swift
//  trivia
//
//  Created by Ueta, Lucas T on 2/15/24.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([
            getNavigationController("Setup", image: UIImage(systemName: "wrench.fill"), viewController: Setup()),
            getNavigationController("Play", image: UIImage(systemName: "play.fill"), viewController: Play())
        ], animated: true)
    }

    func getNavigationController(_ title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = image
        navigationController.title = title
        return navigationController
    }
}
