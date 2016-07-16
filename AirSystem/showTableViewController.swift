//
//  showTableViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit


class showTableViewController: UITableViewController {

    var dataArray = [String]()
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("identifer") as! showTableViewCell
        cell.showText?.text = self.dataArray[indexPath.row]
        cell.showText.backgroundColor = UIColor.redColor()
       
        cell.contentView.backgroundColor = UIColor.redColor()
        return cell
        
    }
}
