//
//  AccountTableVC.swift
//  cinego
//
//  Created by 何家红 on 7/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class AccountTableVC: UITableViewController {
    
    private let tableViewCellIDs = ["UserInformationTableViewCell", "UserPastOrdersTableViewCell", "UserUpcomingMovieSessionsTableViewCell"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        if section > 0 {
            return 2
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        // the user account information
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[0], for: indexPath)
            return cell
        }
        
        if indexPath.section > 0 && indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[1], for: indexPath)
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
        
        if indexPath.section > 0 && indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[2], for: indexPath)
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
        
        
        
        return cell
    }
    
    
}