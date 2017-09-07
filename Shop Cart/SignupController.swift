//
//  SignupController.swift
//  Shop Cart
//
//  Created by Kewal Kanojia on 06/09/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import CoreData
import UIKit

class SignupController: UIViewController {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
//    private let ContactSegue = "showHome"
    
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var nameError: UIImageView!
    @IBOutlet weak var emailError: UIImageView!
    @IBOutlet weak var passwordError: UIImageView!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var mobileError: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
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
    
    @IBAction func alreadyUser(_ sender: Any) {
        let lc = LoginController(nibName: "LoginController", bundle: nil)
        self.navigationController?.pushViewController(lc, animated: true)
    }
    
    @IBAction func registerUser(_ sender: Any) {
        if(nameTxt.text == "") {
            errorMsg.isHidden = false
            errorMsg.text = "Please enter first name."
            nameError.isHidden = false
            nameTxt.becomeFirstResponder()
        } else if(emailTxt.text == "") {
            nameError.isHidden = true
            errorMsg.isHidden = false
            errorMsg.text = "Please enter email."
            emailError.isHidden = false;
            emailTxt.becomeFirstResponder()
        } else if(mobileTxt.text == "") {
            emailError.isHidden = true
            errorMsg.isHidden = false
            errorMsg.text = "Please enter email."
            mobileError.isHidden = false;
            mobileTxt.becomeFirstResponder()
        } else if(passwordTxt.text == "") {
            emailError.isHidden = true
            errorMsg.isHidden = false
            errorMsg.text = "Please enter password."
            passwordError.isHidden = false;
            passwordTxt.becomeFirstResponder()
        } else {
            let signupLoading = self.displayLoading();
            errorMsg.isHidden = true
            nameError.isHidden = true
            emailError.isHidden = true
            passwordError.isHidden = true
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            activityIndicator.color = UIColor.darkGray
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            //Register Request
            
            let name = nameTxt.text!
            let email = emailTxt.text!
            let password = passwordTxt.text!
            let phoneno = mobileTxt.text!
            
            let postString = "name=\(name)&email=\(email)&password=\(password)&phoneno=\(phoneno)"
            let a = doHttpRequest(url: "signup.php", method: "POST", params: postString);
            let status = a?["status"] as! String
            if(status == "false") {
                signupLoading.dismiss(animated: false, completion: {
                    self.errorMsg.isHidden = false
                    self.errorMsg.text = a?["error"] as? String
                })
            } else {
                signupLoading.dismiss(animated: false, completion: {
                    let sessionToken = a?["sessionToken"] as! String
                    UserDefaults.standard.set(sessionToken, forKey: "sessionToken")
                    let hc = HomeController(nibName: "HomeController", bundle: nil)
                    self.navigationController?.pushViewController(hc, animated: true)
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
