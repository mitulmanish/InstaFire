//
//  MainTabBarController.swift
//  InstaFire
//
//  Created by LIFX Laptop on 15/10/17.
//  Copyright © 2017 LIFX Laptop. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
		let navController = UINavigationController(rootViewController: userProfileController)
		navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
		navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
		
		tabBar.tintColor = .black
		viewControllers = [navController, UIViewController()]
	}
}
