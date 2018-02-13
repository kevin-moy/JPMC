//
//  Extensions.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import Foundation

extension String {
    func convertDateToShort(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MMM d, yyyy"
        let shortDate = dateFormatter.string(from: date!)
        return shortDate
    }
}
