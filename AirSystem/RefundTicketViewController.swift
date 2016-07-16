//
//  RefundTicketViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit
import FMDB
import PKHUD

class RefundTicketViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var flightRouteNO: UITextField!
    @IBAction func refund(sender: UIButton) {
        let name = self.name.text ?? ""
        let flightRouteNO = self.flightRouteNO.text ?? ""
        if database.open(){
            do{
                try database.executeUpdate("delete from bookBusiness where name=?", values: [name])
                try database.executeUpdate("delete from passenger where name=?", values: [name])
                let rs = try database.executeQuery("select * from flightInfo where flightRouteNO=?", values: [flightRouteNO])
                while rs.next(){
                    
                    var bookCount = Int(rs.intForColumn("bookCount"))
                    var leftCount = Int(rs.intForColumn("leftCount"))
                    bookCount -= 1
                    leftCount += 1
                    try database.executeUpdate("update flightInfo set bookCount=?,leftCount=? where flightRouteNO=? ", values: [bookCount,leftCount,flightRouteNO])
                    HUD.flash(.Success, delay: 1.0){  finished in
                        // Completion Handler
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }
                }
            
            
            }catch let error as NSError{
                debugPrint("failed: \(error.localizedDescription)")
                HUD.flash(.Error,delay: 1.0)
            }
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
