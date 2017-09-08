//
//  TabController.swift
//  Shop Cart
//
//  Created by Mradul Kumar on 08/09/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpViewControllers();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func setUpViewControllers() {
        
        let homeVC:HomeController = HomeController()
        let hotOfferVC:HotOfferController = HotOfferController()
        let cartVC:CartController = CartController()
        let searchVC:CartController = CartController()
        let profileVC:CartController = CartController()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 1)
        homeVC.navigationItem.title = "Shopcart";
        hotOfferVC.tabBarItem = UITabBarItem(title: "Hot offers", image: nil, tag: 1)
        hotOfferVC.navigationItem.title = "Hot Offers";
        cartVC.tabBarItem = UITabBarItem(title: "My Cart", image: nil, tag: 1)
        cartVC.navigationItem.title = "Shopping Cart";
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 1)
        searchVC.navigationItem.title = "Search";
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 1)
        profileVC.navigationItem.title = "Profile";
        
        var arrayControllers:Array<UIViewController>;
        arrayControllers = Array<UIViewController>();
        arrayControllers.insert(profileVC, at: 0)
        arrayControllers.insert(searchVC, at: 0)
        arrayControllers.insert(cartVC, at: 0)
        arrayControllers.insert(hotOfferVC, at: 0)
        arrayControllers.insert(homeVC, at: 0)
        
        self.setViewControllers(arrayControllers, animated: true)
        
    }
}
