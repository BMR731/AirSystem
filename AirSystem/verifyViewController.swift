//
//  verifyViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 7/1/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit
import PKHUD


class verifyViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var pwd: UITextField!
    
    @IBAction func login(sender: UIButton) {
        verfiyPassed()
        if FLAG{
            
            (HUD.flash(.Success,delay: 1.0))
        }else{
            (HUD.flash(.Error,delay: 1.0))
            
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        self.login.backgroundColor = UIColor.cyanColor()
    }
    
    func verfiyPassed() -> Bool {
        if username.text == "owner" {
            if pwd.text == "2016"{
                FLAG = true
                return true
            }
            
        }
        return false
    }
}