//
//  showTableViewCell.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit

class showTableViewCell: UITableViewCell {
 
    @IBOutlet weak var showText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
       super.setSelected(true, animated: true)
    }
}
