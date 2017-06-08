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
    @IBOutlet weak var avatar: UIImageView!
    
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
            
            UserService.instance.registerUserWith(username: username, email: email, password: password, avatar: avatar.image!) {
                (error: UserServiceError?) -> Void in
                if let error = error, case let UserServiceError.RegisterError(msg) = error {
                    ProgressHUD.showError(msg)
                } else {
                    ProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "ShowRecent", sender: self)
                }
            }
        } else {
            ProgressHUD.showError("All fields can't empty")
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseAvatar(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Set your avatar", preferredStyle: .actionSheet)
        let chooseFromLibrary = UIAlertAction(title: "Choose from library", style: .default) {
            [unowned self] (action: UIAlertAction) -> Void in
            MediaService.instance.image.choosePhotoFromLibrary(for: self) {
                [unowned self] (image: UIImage?) -> Void in
                self.avatar.image = image
            }
        }
        let takePhoto = UIAlertAction(title: "Take photo", style: .default) {
            [unowned self] (action: UIAlertAction) -> Void in
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(chooseFromLibrary)
        alertController.addAction(takePhoto)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
