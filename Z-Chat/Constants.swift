//
//  Constants.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/6.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

let backendless = Backendless.sharedInstance()
let firebase = FIRDatabase.database().reference()
let userDefaults = UserDefaults.standard

let BACKENDLESS_APP_ID = "42B85C94-18E8-2BBE-FF57-2500CC14CB00"
let BACKENDLESS_SECRECT_KEY = "42B85C94-18E8-2BBE-FF57-2500CC14CB00"
let BACKENDLESS_VERSION_NUM = "v1"

public let kAVATARSTATE = "avatarState"
public let kFIRSTRUN = "firstRun"
public let kNUMBEROFMESSAGES = 40
public let kMAXDURATION = 5.0
public let kSUCCESS = 2


