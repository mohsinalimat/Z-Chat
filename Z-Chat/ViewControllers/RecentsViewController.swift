//
//  RecentsViewController.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/12.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var recents = [[String: BackendlessUser]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addUser(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add User", message: nil, preferredStyle: .actionSheet)
        
        let allUsers = UIAlertAction(title: "All Users", style: .default) {
            (action: UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "ShowFriends", sender: self)
        }
        let friends = UIAlertAction(title: "Friends", style: .default) {
            (action: UIAlertAction) -> Void in
        }
        let cancel = UIAlertAction(title: "Cacenl", style: .cancel, handler: nil)
        
        alertController.addAction(allUsers)
        alertController.addAction(friends)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }

    // Mark: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCell") as! RecentCellTableViewCell
        
        return cell
    }
    
    // Mark: - TableView Delegate
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
