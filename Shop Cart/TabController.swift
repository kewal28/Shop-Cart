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
        
        
        let loginVC:LoginController = LoginController()
        let homeVC:HomeController = HomeController()
        let welcomeVC:WelcomeController = WelcomeController()
        
        var arrayControllers:Array<UIViewController>;
        arrayControllers = Array<UIViewController>();
        arrayControllers.insert(loginVC, at: 0)
        arrayControllers.insert(homeVC, at: 0)
        arrayControllers.insert(welcomeVC, at: 0)
        
        self.setViewControllers(arrayControllers, animated: true)
        
    }
}
