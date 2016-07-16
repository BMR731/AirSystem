//
//  BookTicketViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit
import FMDB
import PKHUD

class BookTicketViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var flightRouteNO: UITextField!
    @IBOutlet weak var seatNO: UITextField!
    @IBOutlet weak var idNO: UITextField!
    
    @IBAction func book(sender: UIButton) {
        let name = self.name.text
        let flightRouteNO = self.flightRouteNO.text
        let seatNO = self.seatNO.text
        let idNO = self.idNO.text
        
        if database.open(){
            do{
                let result = try database.executeQuery("select * from passenger where name=?", values: [name!])
                var idNOText:String?
                while result.next(){
                    idNOText = result.stringForColumn("idNO")
                }
                if idNOText == nil{
                    HUD.flash(.LabeledError(title: "请创建新乘客", subtitle: nil),delay: 1.0)
                    return
                }
                let rs = try database.executeQuery("select * from flightInfo where flightRouteNO=?" , values: [flightRouteNO ?? ""])
                while rs.next(){
                    
                    var leftCount = Int(rs.intForColumn("leftCount"))
                    var bookCount = Int(rs.intForColumn("bookCount"))
                    if leftCount>0 {
                        try database.executeUpdate("insert into bookBusiness(name,flightRouteNO,seatNO) values (?,?,?)", values: [name ?? "", flightRouteNO ?? "", seatNO ?? ""])
                        bookCount += 1
                        leftCount -= 1
                        try database.executeUpdate("update flightInfo set bookCount=?, leftCount=? where flightRouteNO=?", values: [bookCount,leftCount,flightRouteNO ?? ""])
                        
                        HUD.flash(.Success, delay: 1.0) { finished in
                            // Completion Handler
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    }else{
                        HUD.flash(.LabeledError(title: "航班客满", subtitle: nil))
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
                
            }catch let error as NSError {
                debugPrint("failed: \(error.localizedDescription)")
                HUD.flash(.Error,delay: 1.0)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idNO.enabled = true
        self.name.text = NAME ?? ""
        self.idNO.text = IDNO ?? ""
    
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.name.text = NAME ?? ""
        self.idNO.text = IDNO ?? ""
        
    }
    override func viewDidAppear(animated: Bool) {
        self.name.text = NAME ?? ""
        self.idNO.text = IDNO ?? ""
//        self.name.text = ""
//        self.idNO.text = ""
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
