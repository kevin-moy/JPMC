//
//  ApiManager.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let sharedInstance = ApiManager()
    
    func getUpcomingLaunches(_ launchFilter: String?, startDateFilter: String?, endDateFilter: String?, completionHandler:@escaping (_ launches: [LaunchObject]?, _ error: String?) -> Void) {
        
        var launchArray = [LaunchObject]()
        // Construct URL
        var urlString = Constants.spacexURL
        
        if launchFilter != nil {
            urlString.append(Constants.launchYearURL + launchFilter!)
        }
        if startDateFilter != nil {
            urlString.append(Constants.startDateURL + startDateFilter!)
        }
        
        if endDateFilter != nil {
            urlString.append(Constants.endDateURL + endDateFilter!)
        }
        
        let url = URL(string: urlString)!
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print(error!)
                completionHandler(nil, error as! String?)
                return
            }
            guard data != nil else {
                print("Data is empty")
                return
            }
            
            if error != nil {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            
            do {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                guard let spacexJSON = json as? [[String: Any]] else {
                    completionHandler(nil, "JSON not a dictionary")
                    return }
                // Get JSON data and put it in Launch Object
                for feedData in spacexJSON {
                    let feed = LaunchObject.init(json: feedData)
                    launchArray.append(feed)
                }
                completionHandler(launchArray, nil)
            }
        })
        task.resume()
        group.notify(queue: .main) {
            completionHandler(launchArray, nil)
        }
}
}
