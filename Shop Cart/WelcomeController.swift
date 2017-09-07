//
//  WelcomeController.swift
//  Shop Cart
//
//  Created by Kewal Kanojia on 06/09/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getStarted(_ sender: Any) {
        let hc = SignupController(nibName: "SignupController", bundle: nil)
        self.navigationController?.pushViewController(hc, animated: true)
    }

}
