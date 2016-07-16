//
//  database.swift
//  AirSystem
//
//  Created by 胡胡赛军 on 6/30/16.
//  Copyright © 2016 胡胡赛军. All rights reserved.
//

import Foundation
import FMDB


let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
let fileURL = documents.URLByAppendingPathComponent("airsystem.sqlite")

let database = FMDatabase(path: fileURL.path)

func handleDatabase(){
    
    if database.open(){
        
        do{
            try database.executeUpdate("create table if not exists flightInfo(flightRouteNO text primary key , flyNO text not null , destination text not null , bookCount integer not null ,leftCount integer not null)", values: nil)
            try database.executeUpdate("create table if not exists passenger(name text not null, idNO text primary key )", values: nil)
            try database.executeUpdate("create table if not exists bookBusiness(name text primary key,flightRouteNO text not null , seatNO text not null unique )", values: nil)
//            try database.executeUpdate("drop table passenger", values: nil)
//            try database.executeUpdate("drop table bookBusiness", values: nil)
//            try database.executeUpdate("drop table flightInfo", values: nil)
        }catch let error as NSError{
            debugPrint("failed: \(error.localizedDescription)")
        }
        
    }
}