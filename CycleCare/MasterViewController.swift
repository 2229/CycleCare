//
//  MasterViewController.swift
//  CycleCare
//
//  Created by CGS Spare on 3/07/2015.
//  Copyright (c) 2015 tidbit. All rights reserved.
//

import Foundation
import UIKit

class MasterViewController: UIViewController {
    private let crashAPIKey = "105ae96ec1715a02bcf2eaa13b1c8fbe"
   

    
    let coordinate: (lat: Double, long: Double) = (37.8, 49.6)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let crashService = CrashService(APIKey: crashAPIKey)
        crashService.getCrash(coordinate.lat, long: coordinate.long) {
            (let currently) in
            if let currentCrashSites = currently{

                    

            }
            
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
}
