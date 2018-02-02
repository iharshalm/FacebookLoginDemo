//
//  ViewController.swift
//  FacebookLoginDemo
//
//  Created by GlobalLogic on 30/01/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit

class ViewController: UIViewController {
    
    // MARK:- Life Cycle Methods
    let myLoginButton = UIButton(type: UIButtonType.custom) as UIButton
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpLoginButtonUI()
        setTitleToLoginButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Custom Methods
    func setUpLoginButtonUI() {
        
        //let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends])
        //loginButton.center = view.center
        //view.addSubview(loginButton)
        
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 20, y: 20, width: 180, height: 40);
        myLoginButton.center = view.center;
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        self.view.addSubview(myLoginButton)
    }
    
    func setTitleToLoginButton() {
        
        if let _ = FBSDKAccessToken.current() {
            myLoginButton.setTitle("Logout", for: .normal)
        } else {
            myLoginButton.setTitle("Login", for: .normal)
        }
    }
    
    // MARK:- Action Methods
    @objc func loginButtonClicked() {
        
        if let _ = FBSDKAccessToken.current() {
            logoutToFacebook()
        } else {
            loginToFacebook()
        }
    }
    
    // MARK:- Login/Logout Methods
    func loginToFacebook() {
        
        loginManager.logIn(readPermissions: [.email , .userFriends], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error ):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(grantedPermissions: _, declinedPermissions: _, token: let accessTocken):
                print("Tocken is :\(accessTocken)")
                self.setTitleToLoginButton()
            }
        }
    }
    
    func logoutToFacebook() {
        loginManager.logOut()
        setTitleToLoginButton()
    }
    
}

