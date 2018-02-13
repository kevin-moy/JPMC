//
//  RocketObject.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import Foundation

class RocketObject {
    var name: String?
    var type: String?
    var avatarURL: String?
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let rocketName = json["rocket_name"] {
            name = rocketName as? String
        }
        
        if let rocketType = json["rocket_type"] {
            type = rocketType as? String
        }
        
    }
    
}
