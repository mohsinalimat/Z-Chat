//
//  FriendsViewController.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/13.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [BackendlessUser]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 60
        
        ProgressHUD.show()
        UserService.instance.getAllUsers {
            [weak self] (users: [BackendlessUser]?, error: UserServiceError?) -> Void in
            if let error = error,  case let UserServiceError.RetrieveUsersError(msg) = error {
                ProgressHUD.showError(msg)
            } else {
                ProgressHUD.dismiss()
                self?.users = users
                self?.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendsTableViewCell
        cell.user = users?[indexPath.row]
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FriendsTableViewCell {
            cell.cancelTask()
        }
    }
}
