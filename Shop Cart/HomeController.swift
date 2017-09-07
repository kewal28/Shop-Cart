//
//  HomeController.swift
//  Shop Cart
//
//  Created by Kewal Kanojia on 06/09/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit
import SDWebImage

class HomeController: UIViewController {

    @IBOutlet weak var homeSlider: UIScrollView!
    var sliderImageName = [String]()
    var sliderImage:[String: Any] = [:];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.title = "Shopcart";
        let menuIcon = UIBarButtonItem(image: UIImage(named: "menu-icon"), style: .plain, target: self, action: #selector(showMenu)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = menuIcon
        
        let logout = UIBarButtonItem(image: UIImage(named: "menu-icon"), style: .plain, target: self, action: #selector(logoutUser)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = logout

//        self.createSlider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func showMenu() {
        print("Click")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func createSlider() {
        //Get Slider Image From API Call
        if let categoryListCoreData = UserDefaults.standard.object(forKey: "sliderImage") as? [String: Any] {
            sliderImage = categoryListCoreData;
        } else {
            sliderImage = doHttpRequest(url: "slider.php", method: "GET", params: "")!;
            UserDefaults.standard.set(sliderImage, forKey: "sliderImage");
        }
        
        if !(sliderImage.isEmpty) {
            let status = sliderImage["status"] as! String
            if(status == "false") {
                print(sliderImage["error"]!);
            } else {
                let sliderImageArray: NSArray = sliderImage["slider"] as! NSArray
                for i in 0 ..< sliderImageArray.count{
                    //getting the data at each index
                    let sliderArray = sliderImageArray[i] as! Dictionary<String,AnyObject>
                    let sliderImage = self.sliderBaseUrl()+(sliderArray["sliderImage"]! as! String)
                    sliderImageName.append(sliderImage)
                }
            }
        }
        
        for i in 0..<sliderImageName.count {
            let imageView = UIImageView()
            let mediaURL = URL(string: sliderImageName[i]);
            let _ = try! Data(contentsOf: mediaURL!);
            let _ = SDWebImageDownloader.shared().downloadImage(with: mediaURL, options: [], progress: nil, completed: { (image, data, error, finished) in
                DispatchQueue.main.async {
                    imageView.image = image
                }
            })
            
//            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y:0 , width: self.homeSlider.frame.width, height: self.homeSlider.frame.height)
            
            homeSlider.contentSize.width = homeSlider.frame.width * CGFloat(i+1)
            homeSlider.addSubview(imageView)
        }
    }
    
    
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: "sessionToken")
        let lc = LoginController(nibName: "LoginController", bundle: nil)
        self.navigationController?.pushViewController(lc, animated: true)
    }

    

}
