//
//  CrashService.swift
//  CycleCare
//
//  Created by CGS Spare on 3/07/2015.
//  Copyright (c) 2015 tidbit. All rights reserved.
//

import Foundation
struct CrashService {
    let crashAPIKey: String
    let crashBaseURL: NSURL?
    init(APIKey: String){
        self.crashAPIKey = APIKey
        crashBaseURL = NSURL(string: "https://www.data.act.gov.au/api/views/n2kg-qkwj/rows.json")
    }
    func getCrash(lat: Double, long: Double, completion: (CurrentCrashSites? -> Void)){
        if let crashURL = NSURL(string: "", relativeToURL: crashBaseURL){
            let networkOperation = NetworkOperation(url: crashURL)
            networkOperation.downloadJSONFromURL{
                (let JSONDictionary) in
                //1. Parse the contents of the dictionary
                let currentCrash = self.currentCrashSitesFromJSONDictionary(JSONDictionary)
                
                
                //2. Create a populated instance of current weather
                completion(currentCrash)
                
            }
        } else{
            println("Could not construct a valid URL")
        }
    }
    
    
    
    func currentCrashSitesFromJSONDictionary(jsonDictionary: ([String: AnyObject]?)) -> CurrentCrashSites?{
        println("RUN!")
        var currentCrashDictionary: AnyObject? = jsonDictionary?["data"]
        if (currentCrashDictionary != nil){
            
            var latitudesArray : [Double] = []
            var longitudesArray : [Double] = []
            var informationArray : [String] = []
            var damageArray : [String] = []
            for index in 1..<currentCrashDictionary!.count{
                
                var latitudes = currentCrashDictionary![index]
                var overallLatitude = latitudes! as! NSArray
                var lat =  (overallLatitude.objectAtIndex(16) as! NSString).doubleValue
                latitudesArray.append(lat)
                
                
                var longitudes = currentCrashDictionary![index]
                var overallLongitude = longitudes! as! NSArray
                var long =  (overallLongitude.objectAtIndex(17) as! NSString).doubleValue
                longitudesArray.append(long)
                
                var information = currentCrashDictionary![index]
                var overallInformation = information! as! NSArray
                var info =  (overallInformation.objectAtIndex(12) as! NSString)
                informationArray.append(info as String)
                
                var damage = currentCrashDictionary![index]
                var overallDamage = damage! as! NSArray
                var damages =  (overallDamage.objectAtIndex(11) as! NSString)
                damageArray.append(damages as String)
            }
            var combinedCoordinates : [[Double]] = []
            for combinedItem in latitudesArray {
                combinedCoordinates.append([combinedItem,longitudesArray[find(latitudesArray, combinedItem)!]])
            }
            
            println(combinedCoordinates)

            Main.sharedInstance.name = combinedCoordinates
            
            Main.sharedInstance.two = informationArray
            
            Main.sharedInstance.damage = damageArray
            
            
            println("The instance is \(Main.sharedInstance.two)")
        }
        if let currentCrashDictionary = jsonDictionary?["meta"] as? [String: AnyObject]{
            //Return the instance
            return CurrentCrashSites(coordinateDictionary: currentCrashDictionary)
        } else{
            println("JSON Dictionary returned nil for 'currently' key")
            return nil
        }
    }
}