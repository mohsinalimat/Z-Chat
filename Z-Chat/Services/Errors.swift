//
//  Error.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/7.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import Foundation

enum UserServiceError: Error {
    case UnknownError(String)
    case ServiceError(String)
    case LoginError(String)
    case EmptyError(String)
    case RegisterError(String)
    case UploadError(String)
}
