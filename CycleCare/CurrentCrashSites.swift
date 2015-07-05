//
//  CurrentCrashSites.swift
//  CycleCare
//
//  Created by CGS Spare on 3/07/2015.
//  Copyright (c) 2015 tidbit. All rights reserved.
//

import Foundation
struct CurrentCrashSites {
    var latitude: Double?
    var longitude: Double?
    init(coordinateDictionary: [String: AnyObject]){
        latitude  = coordinateDictionary["latitude"] as? Double
        longitude = coordinateDictionary["longitude"] as? Double

    }
}