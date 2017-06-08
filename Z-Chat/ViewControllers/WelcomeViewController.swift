//
//  WelcomeViewController.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/6.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserService.instance.hasLoggedIn() {
            self.performSegue(withIdentifier: "ShowRecent", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Actions
    
    @IBAction func login(_ sender: UIButton) {
        if let username = username.text, let password = password.text, !username.isEmpty && !password.isEmpty {
            ProgressHUD.show("Log in...", interaction: true)
            UserService.instance.loginUserWith(username: username, password: password) {
                [unowned self] (error: UserServiceError?) -> Void in
                if let error = error, case let UserServiceError.LoginError(msg) = error {
                    ProgressHUD.showError(msg)
                } else {
                    ProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "ShowRecent", sender: self)
                }
            }
        } else {
            ProgressHUD.showError("All fields can't be empty")
        }
    }
}
