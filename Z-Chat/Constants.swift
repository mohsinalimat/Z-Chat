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

let BACKENDLESS_APP_ID = "CC6F2D35-A36A-4BC1-FF67-06C7C2453F00"
let BACKENDLESS_SECRECT_KEY = "5C149EF5-9E1F-4FE4-FF3C-AE38D5BC1500"
let BACKENDLESS_VERSION_NUM = "v1"

public let kAVATARSTATE = "avatarState"
public let kAVATARPATH = "Image/Avatar"
public let kAVATARKEY = "Avatar"
public let kFIRSTRUN = "firstRun"
public let kNUMBEROFMESSAGES = 40
public let kMAXDURATION = 5.0
public let kSUCCESS = 2




