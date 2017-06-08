//
//  UserService.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/7.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import Foundation
import Dispatch

class UserService {
    
    static let instance: UserService = UserService()
    
    init() {
        
    }
    
    func hasLoggedIn() -> Bool {
        let user = backendless?.userService.currentUser
        return user != nil
    }
    
    func currentUser() -> BackendlessUser? {
        return backendless?.userService.currentUser
    }
    
    func loginUserWith(username: String, password: String, completion: @escaping (_ error: UserServiceError?) -> Void ) {
        if let backendless = backendless {
            backendless.userService.login(username, password: password, response: {
                (user: BackendlessUser?) -> Void in
                completion(nil)
            }, error: {
                (fault: Fault?) -> Void in
                completion(UserServiceError.LoginError(fault!.detail))
            })
        } else {
            fatalError("BackendLess service error")
        }
    }
    
    func registerUserWith(username: String, email: String, password: String, avatar: UIImage?, completion: @escaping (_ error: UserServiceError?) -> Void) {
        if let backendless = backendless {
            let user = BackendlessUser()
            user.name = username as NSString
            user.email = email as NSString
            user.password = password as NSString
            user.setProperty(kAVATARKEY, object: "")
            
            backendless.userService.registering(user, response: {
                (user: BackendlessUser?) -> Void in
                if let avatar = avatar, let file = self.uploadUserAvatar(avatar) {
                    user?.setProperty(kAVATARKEY, object: file.fileURL)
                    backendless.userService.update(user)
                }
                completion(nil)
            }, error: {
                (fault: Fault?) -> Void in
                completion(UserServiceError.RegisterError(fault!.detail))
            })
        } else {
            fatalError("BackendLess service error")
        }

    }
    
    fileprivate func uploadUserAvatar(_ avatar: UIImage) -> BackendlessFile? {
        if let backendless = backendless, let imageData = UIImagePNGRepresentation(avatar) {
            let filePath = "\(kAVATARPATH)/avatar-\(String.currentDateTimeString()).png"
            return backendless.fileService.upload(filePath, content: imageData)
        }
        
        return nil
    }
}
