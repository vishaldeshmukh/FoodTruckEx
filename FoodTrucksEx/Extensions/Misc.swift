//
//  Misc.swift
//  FoodTrucks
//
//  Created by Hai Nguyen on 8/6/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
