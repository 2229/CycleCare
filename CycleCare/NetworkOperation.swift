//
//  NetworkOperation.swift
//  CycleCare
//
//  Created by CGS Spare on 3/07/2015.
//  Copyright (c) 2015 tidbit. All rights reserved.
//

import Foundation

class NetworkOperation{
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]? -> Void)
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion:JSONDictionaryCompletion){
        //Create an instance of NSURLRequest
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        
        //Pass in the request for the first parameter of the data task
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            //1. Check HTTP response for successful GET request
            
            //Cast response to the NSHTTPURLResponse type, so that its status can be checked
            if let httpResponse = response as? NSHTTPURLResponse{
                //Check the status of the request to make sure it was successful
                switch(httpResponse.statusCode) {
                    //case 200: successful completion
                case 200:
                    //2. Create JSON object with data
                    let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject]
                    //Return jsonDictionary
                    completion(jsonDictionary)
                    
                default:
                    println("Get request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
            } else{
                println("Error: Not a valid HTTP response")
            }
            
            
        }
        dataTask.resume() //Get things started
    }
    
}