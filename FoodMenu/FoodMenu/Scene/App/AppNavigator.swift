//
//  AppNavigator.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 10/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Then

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toMain() {
        let tabBar = UITabBarController()
        configureTabBar(tabBar: tabBar)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
    
    func configureTabBar(tabBar: UITabBarController) {
        let homeVC = UINavigationController.setUpHomeController()
        let favouriteVC = UINavigationController.setUpFavouriteController()
        homeVC.tabBarItem.image = UIImage(systemName: L10n.homeIcon)
        favouriteVC.tabBarItem.image = UIImage(systemName: L10n.favoriteIcon)
        homeVC.title = L10n.homeTabTitle
        favouriteVC.title = L10n.favoriteTabTitle
        tabBar.then {
            $0.tabBar.barTintColor = .white
            $0.setViewControllers([homeVC, favouriteVC], animated: true)
        }
    }
}
