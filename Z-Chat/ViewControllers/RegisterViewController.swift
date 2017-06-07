//
//  RegisterViewController.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/7.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: UIButton) {
        if let username = username.text, let email = email.text, let password = password.text, !username.isEmpty && !email.isEmpty && !password.isEmpty {
            ProgressHUD.show("Registering...", interaction: true)
            
            UserService.instance.registerUserWith(username: username, email: email, password: password, avatar: nil) {
                (error: UserServiceError?) -> Void in
                if let error = error, case let UserServiceError.RegisterError(msg) = error {
                    ProgressHUD.showError(msg)
                } else {
                    ProgressHUD.dismiss()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RectViewController")
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        } else {
            ProgressHUD.showError("All fields can't empty")
        }
    }

}
