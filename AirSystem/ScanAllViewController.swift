//
//  ScanAllViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit
import FMDB

class ScanAllViewController: UIViewController {
    
    var passengers:Array = [String]()
    var flights:Array = [String]()
    
    @IBAction func flights(sender: UIButton) {
//        let showTableVC = showTableViewController()
//        showTableVC.dataArray = self.flights
//        let _  = UIStoryboardSegue(identifier: "flights", source: self, destination: showTableVC)
//        
////        performSegueWithIdentifier("flights", sender: nil)
//        let storyboard
//        self.performSegueWithIdentifier("flights", sender: nil)
        
    }
    @IBAction func passengers(sender: UIButton) {
//        let showTableVC = showTableViewController()
//        showTableVC.dataArray = self.passengers
//        let _ = UIStoryboardSegue(identifier: "passengers", source: self, destination: showTableVC)
//        performSegueWithIdentifier("passengers", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scanPassenger()
        scanFlight()
        scanPerson()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //bookBuniness(name text reference passenger(name),flightRouteNO text reference flightInfo(flightRouteNO), seatNO text
    func scanPassenger() {
        if database.open(){
            do{
                let rs = try database.executeQuery("select name, flightRouteNO, seatNO from bookBusiness", values: nil)
                while rs.next() {
                    let x = rs.stringForColumn("name")
                    let y = rs.stringForColumn("flightRouteNO")
                    let z = rs.stringForColumn("seatNO")
                    let description =  "姓名:\(x);航班号：\(y);座位号 = \(z)"
                    self.passengers.append(description)
                    print(description)
                }
                
            }catch let error as NSError {
                debugPrint("failed: \(error.localizedDescription)")
            }
        }
        
    }
    //"create table if not exists flightInfo(flightRouteNO text primary key , flyNO text , destination text , bookCount integer ,leftCount integer)", values: nil)
    func scanFlight() {
        if database.open(){
            do{
                let rs = try database.executeQuery("select * from flightInfo", values: nil)
                while rs.next() {
                    let x = rs.stringForColumn("flightRouteNO")
                    let y = rs.stringForColumn("flyNO")
                    let z = rs.stringForColumn("destination")
                    let a = rs.intForColumn("bookCount")
                    let b = rs.intForColumn("leftCount")
                    let description =  "航班号:\(x);飞机号:\(y);目的地:\(z)已预定:\(a);剩余:\(b)"
                    self.flights.append(description)
                    print(description)
                }
                
            }catch let error as NSError {
                debugPrint("failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    func scanPerson() {
        if database.open(){
            do{
                let rs = try database.executeQuery("select * from passenger", values: nil)
                while rs.next() {
                    let x = rs.stringForColumn("name")
                    let y = rs.stringForColumn("idNO")
           
                    let description =  "姓名:\(x);身份证号:\(y)"
                    
                    debugPrint(description)
                }
                
            }catch let error as NSError {
                debugPrint("failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "flights" {
            let VC = segue.destinationViewController as! showTableViewController
            VC.dataArray = self.flights
        }
        if segue.identifier == "passengers" {
            let VC = segue.destinationViewController as! showTableViewController
            VC.dataArray = self.passengers
        }
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
