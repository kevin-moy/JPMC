//
//  LaunchViewModel.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import Foundation

class LaunchViewModel {
    
    var launch = [LaunchObject]()
    
    func clearFeed() {
        launch = []
    }
    
    func feedRequest(_ launchFilter: String?, startDateFilter: String?, endDateFilter: String?, completionHandler:@escaping (_ succeed: Bool, _ error: String?) -> Void) {
  
        ApiManager.sharedInstance.getUpcomingLaunches(launchFilter, startDateFilter: startDateFilter, endDateFilter: endDateFilter) { (launches, error) in
            if let fetchedLaunches = launches {
                self.launch.append(contentsOf: fetchedLaunches)
                completionHandler(true, nil)
            }
            else {
                completionHandler(false, error)
            }
        }
    }
    
}
