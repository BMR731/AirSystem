//
//  AddFlightRouteViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//
//let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
//let fileURL = documents.URLByAppendingPathComponent("test.sqlite")
//
//let database = FMDatabase(path: fileURL.path)
//
//if !database.open() {
//    print("Unable to open database")
//    return
//}
//
//do {
//    try database.executeUpdate("create table test(x text, y text, z text)", values: nil)
//    try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["a", "b", "c"])
//    try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["e", "f", "g"])
//    
//    let rs = try database.executeQuery("select x, y, z from test", values: nil)
//    while rs.next() {
//        let x = rs.stringForColumn("x")
//        let y = rs.stringForColumn("y")
//        let z = rs.stringForColumn("z")
//        print("x = \(x); y = \(y); z = \(z)")
//    }
//} catch let error as NSError {
//    print("failed: \(error.localizedDescription)")
//}
//
//database.close()
import UIKit
import FMDB
import PKHUD

class AddFlightRouteViewController: UIViewController {

    @IBOutlet weak var flightRouteNO: UITextField!
    @IBOutlet weak var flyNO: UITextField!
    
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var bookCount: UITextField!
    @IBOutlet weak var leftCount: UITextField!
    
    @IBOutlet weak var isModify: UISwitch!
    @IBAction func submmit(sender: AnyObject) {
        let flightRouteNO =  self.flightRouteNO.text
        let flyNO = self.flyNO.text
        let destination = self.destination.text
        let bookCount = (self.bookCount.text! as NSString).integerValue
        let leftCount = (self.leftCount.text! as NSString).integerValue
        
        if database.open(){
            do{
                if(self.isModify.on){
                    try database.executeUpdate("delete from flightInfo where flightRouteNO=?", values:[flightRouteNO ?? ""])
                }
                try database.executeUpdate("insert into flightInfo(flightRouteNO,flyNO,destination,bookCount,leftCount) values (?,?,?,?,?) ",values: [flightRouteNO ?? "",flyNO ?? "",destination ?? "",bookCount,leftCount])
                
                HUD.flash(.Success, delay: 1.0) { finished in
                    // Completion Handler
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }catch let error as NSError {
                debugPrint("failed: \(error.localizedDescription)")
                HUD.flash(.Error,delay: 1.0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModify.on = false
        
        if !database.open(){
            debugPrint("unable to open")
        }
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
