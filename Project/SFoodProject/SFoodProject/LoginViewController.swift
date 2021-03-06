//
//  LoginViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/4/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let readAPI = ReadAPI()
    
    var messageFrame = UIView()
    
    var imagesDataAPI: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewWillAppear(animated: Bool) {
        self.usernameTextField.text = "admin"
        self.passwordTextField.text = "admin"
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        let username = self.usernameTextField.text!
        let password = self.passwordTextField.text!
        
//        var imagesAPI: [UIImage] = []
//        
//        if self.readAPI.images.count > 5 {
//            imagesAPI = self.readAPI.images
//        } else {
//            if let urlData = NSURL(string: "https://www.intego.com/mac-security-blog/wp-content/uploads/2016/02/Apple_Swift_logo.png") {
//                if let data = NSData(contentsOfURL: urlData) {
//                    imagesAPI = [UIImage(data: data)!]
//                }
//            }
//        }
        
        
        if self.checkAccount(username, password: password) {
            //print("Dang nhap thanh cong")
            progressBarDisplayer(true)
            
            runAfterDelay(0.5) {
                AppDelegate.sharedInstance.idUser = self.getIdUser(username, password: password)
                AppDelegate.sharedInstance.changeRootViewWhenLoginSuccess()
//                let imageAPIViewController = ImageAPIViewController(nibName: "ImageAPIViewController", bundle: nil)
//                imageAPIViewController.images = self.imagesDataAPI
//                print(self.imagesDataAPI)
//                self.navigationController?.pushViewController(imageAPIViewController, animated: true)
                self.messageFrame.removeFromSuperview()
            }
            
            
        } else {
            if self.checkValid(username, password: password) {
                self.showMessage("Input Not Valid")
            } else {
                self.showMessage("User Not Available")
            }
        }
    }
    @IBAction func forgotPasswordAction(sender: AnyObject) {
        //print("Quen Mat Khau")
        let forgotPassword = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPassword, animated: true)
        
    }
    @IBAction func registerAction(sender: AnyObject) {
        //print("Dang Ky")
        let register = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(register, animated: true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func checkAccount(username: String, password: String) -> Bool {
        let path = NSBundle.mainBundle().pathForResource("users", ofType: "plist")
        let users = NSArray(contentsOfFile: path!)
        
        for user in users! {
            let _username = user.objectForKey("username") as! String
            let _password = user.objectForKey("password") as! String
            if username == _username && password == _password {
                return true
            }
        }
        
        return false
    }
    
    func getIdUser(username: String, password: String) -> Int {
        
        let path = NSBundle.mainBundle().pathForResource("users", ofType: "plist")
        let users = NSArray(contentsOfFile: path!)
        
        for user in users! {
            let _id = user.objectForKey("id") as! Int
            let _username = user.objectForKey("username") as! String
            let _password = user.objectForKey("password") as! String
            if username == _username && password == _password {
                return _id
            }
        }
        return 0

    }
    
    func checkValid(username: String, password: String) -> Bool {
        if username == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    
    
    
    
    
    func progressBarDisplayer(indicator: Bool) {
        
        var activityIndicator = UIActivityIndicatorView()
        messageFrame = UIView(frame: self.view.bounds)
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: messageFrame.frame.size.width/2 - 25, y: messageFrame.frame.size.height/2 - 25, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        view.addSubview(messageFrame)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            self.loginAction(self)
        }
        return true
    }
}




