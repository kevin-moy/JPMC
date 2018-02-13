//
//  LaunchObject.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import Foundation

class LaunchObject {
    var flightNumber: String?
    var year: String?
    var site: String?
    var rocket: RocketObject!
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let launchFlightNumber = json["flight_number"] {
            flightNumber = launchFlightNumber as? String
        }
        
        if let launchYear = json["launch_year"] {
            year = launchYear as? String
        }
        
        if let launchSite = json["launch_site"] as? [String: String] {
            site = launchSite["site_name"]
        }
        
        if let launchRocket = json["rocket"] as? [String: Any] {
            rocket = RocketObject.init(json: launchRocket)
        }
    }
}
