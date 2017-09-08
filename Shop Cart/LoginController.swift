//
//  LoginController.swift
//  Shop Cart
//
//  Created by Kewal Kanojia on 06/09/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import CoreData
import UIKit

class LoginController: UIViewController {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailError: UIImageView!
    @IBOutlet weak var passwordError: UIImageView!
    @IBOutlet weak var errorMsg: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
//        let _ = self.checkLogin(contactSegue: self.ContactSegue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Code
//        let _ = self.checkLogin(contactSegue: self.ContactSegue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skip(_ sender: Any) {
        let hc = HomeController(nibName: "HomeController", bundle: nil)
        self.navigationController?.pushViewController(hc, animated: true)
    }

    //For alert Box
    //self.createAlert(title: "Could not post image", message: "Please try again later")
    
    
    @IBAction func doLogin(_ sender: Any) {
        if(emailTxt.text == "") {
            errorMsg.isHidden = false
            errorMsg.text = "Please enter email id."
            emailError.isHidden = false
            emailTxt.becomeFirstResponder()
        } else if(passwordTxt.text == "") {
            emailError.isHidden = true
            errorMsg.isHidden = false
            errorMsg.text = "Please enter password."
            passwordError.isHidden = false;
            passwordTxt.becomeFirstResponder()
        } else {
            let signinLoading = self.displayLoading();
            errorMsg.isHidden = true
            emailError.isHidden = true
            passwordError.isHidden = true
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            activityIndicator.color = UIColor.darkGray
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            //Login Request
            let postString = "email=\(emailTxt.text!)&password=\(passwordTxt.text!)"
            let loginResp = doHttpRequest(url: "login.php", method: "POST", params: postString);
            if !((loginResp?.isEmpty)!) {
                let status = loginResp?["status"] as! String
                if(status == "false") {
                    signinLoading.dismiss(animated: false, completion: {
                        self.errorMsg.isHidden = false
                        self.errorMsg.text = loginResp?["error"] as? String
                    })
                } else {
                    let sessionToken = loginResp?["sessionToken"] as! String
                    UserDefaults.standard.set(sessionToken, forKey: "sessionToken")
                    signinLoading.dismiss(animated: false, completion: {
                        let hc = HomeController(nibName: "HomeController", bundle: nil)
                        self.navigationController?.pushViewController(hc, animated: true)
                    })
                }
            } else {
                signinLoading.dismiss(animated: false, completion: {
                    self.errorMsg.isHidden = false
                    self.errorMsg.text = "Error while login."
                })
            }
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
