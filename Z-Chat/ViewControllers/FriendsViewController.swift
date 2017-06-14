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
    let searchController = UISearchController(searchResultsController: nil)
    
    var users: [BackendlessUser]? = nil
    var filteredUsers: [BackendlessUser]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 60
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
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
    
    // MARK: - Search users
    func curreantUsers() -> [BackendlessUser]? {
        if (searchController.isActive && searchController.searchBar.text != "") {
            return filteredUsers
        }
        
        return users
    }

    // MARK: - TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return curreantUsers()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendsTableViewCell
        cell.user = curreantUsers()?[indexPath.row]
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FriendsTableViewCell {
            cell.cancelTask()
        }
    }
}

extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            filteredUsers = users?.filter { $0.name.lowercased.contains(text.lowercased()) }
        }
        
        tableView.reloadData()
    }
}
