//
//  global.swift
//  CycleCare
//
//  Created by CGS Spare on 4/07/2015.
//  Copyright (c) 2015 tidbit. All rights reserved.
//

import Foundation

class Main {
    static var sharedInstance = Main(name: [[]], two:[], damage:[])
    var name: [[Double]]?
    var two: [String]?
    var damage: [String]?
    init(name:[[Double]]?, two:[String]?, damage: [String]?) {
        self.name = name
        self.two = two
        self.damage = damage
        
    }
}
