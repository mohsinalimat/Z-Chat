//
//  FriendsTableViewCell.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/13.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import UIKit
import Dispatch

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    static let queue = { () -> DispatchQueue in 
        let q = DispatchQueue(label: "com.z-talk.avatar")
        return q
    }()
    
    var avatarDownloadSlave: DispatchWorkItem? = nil
    
    var user: BackendlessUser? {
        didSet {
            if let name = user?.name as String?, let avatarUrlString = user?.getProperty("Avatar") {
                avatarDownloadSlave?.cancel()
                
                self.name.text = name
                avatarDownloadSlave = DispatchWorkItem(qos: .userInitiated, flags: .detached) {
                    [weak self] () -> Void in
                    if  let urlString = avatarUrlString as? String,
                        let url = URL(string: urlString),
                        let data = try? Data(contentsOf: url),
                        let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.avatar.image = image
                        }
                    }
                }

                if let item = avatarDownloadSlave {
                    FriendsTableViewCell.queue.async(execute: item)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        avatar.image = UIImage(named: "avatar")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.clipsToBounds = true
    }

    func cancelTask() {
        avatarDownloadSlave?.cancel()
    }
}
