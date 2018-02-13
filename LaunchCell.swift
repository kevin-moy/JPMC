//
//  LaunchCell.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import UIKit

class LaunchCell: UITableViewCell {
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var launchYearLabel: UILabel!
    @IBOutlet weak var launchSiteLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    
    func setupCell(launch: LaunchObject) {
        flightNumberLabel.text = "Flight \(String(describing: launch.flightNumber))"
        launchYearLabel.text = "Launch Year: \(launch.year!)"
        launchSiteLabel.text = "Launch Site: \(launch.site!)"
        launchDateLabel.text = "Launch Date: \(launch.date!)"
        rocketNameLabel.text = "Rocket Name: \(launch.rocket.name!)"
        rocketTypeLabel.text = "Rocket Type: \(launch.rocket.type!)"
    }
}
