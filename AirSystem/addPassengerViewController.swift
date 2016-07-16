//
//  addPassengerViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 7/1/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit
import PKHUD


    var NAME: String = ""
    var IDNO: String = ""

class addPassengerViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var idNO: UITextField!

    @IBAction func save(sender: UIButton) {
        NAME = name.text ?? ""
        IDNO = idNO.text ?? ""
        if database.open(){
            do{
               try database.executeUpdate("insert into passenger(name,idNO) values (?,?)", values: [name.text ?? "" ,idNO.text ?? ""])
                
                HUD.flash(.Success, delay: 1.0) { finished in
                    // Completion Handler
                   self.dismissViewControllerAnimated(true, completion: nil)
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }catch let error as NSError {
                debugPrint("failed: \(error.localizedDescription)")
                HUD.flash(.Error,delay: 1.0)
                self.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
