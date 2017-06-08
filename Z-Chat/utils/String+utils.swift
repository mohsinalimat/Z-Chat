//
//  String+utils.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/8.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import Foundation

extension String {
    
    static func currentDateTimeString() -> String {
        let current = Date()
        let format = "yyyy-MM-dd'T'hh-mm-ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: current)
    }
}
