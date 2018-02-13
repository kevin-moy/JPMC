//
//  LaunchObject.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import Foundation

class LaunchObject {
    var flightNumber: Int = 0
    var year: String?
    var site: String?
    var date: String?
    var rocket: RocketObject!
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let launchFlightNumber = json["flight_number"] {
            flightNumber = launchFlightNumber as? Int ?? 0
        }
        
        if let launchYear = json["launch_year"] {
            year = launchYear as? String
        }
        
        if let launchSite = json["launch_site"] as? [String: String] {
            site = launchSite["site_name"]
        }
        
        if let launchDate = json["launch_date_utc"] {
            date = launchDate as? String
        }
        date = date?.convertDateToShort(dateString: date!)
        
        if let launchRocket = json["rocket"] as? [String: Any] {
            rocket = RocketObject.init(json: launchRocket)
        }
    }
}
