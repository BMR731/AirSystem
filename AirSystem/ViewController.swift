//
//  ViewController.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import UIKit

import FMDB


var FLAG = false

class ViewController: UIViewController {

    @IBAction func login(sender: UIButton) {
    }
    @IBAction func addFlightRoute(sender: UIButton) {
    }

    @IBOutlet weak var addFlightRoute: UIButton!
    
    @IBAction func exitSystem(sender: UIButton) {

        let appdelegate = UIApplication.sharedApplication().delegate
        if let window = appdelegate?.window{
        
        UIView.animateWithDuration(0.4, animations: {
            window!.alpha = 0
            let x = window!.bounds.size.height
            let y = window!.bounds.size.width
            window!.frame = CGRectMake(x,y,0,0)
            
            }, completion: { (_) in
                database.close()
                exit(0)
        })
        }
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFlightRoute.enabled = FLAG
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.addFlightRoute.enabled = FLAG
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

