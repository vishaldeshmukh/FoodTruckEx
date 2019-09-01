//
//  FoodTruckModel.swift
//  FoodTrucks
//
//  Created by Hai Nguyen on 8/5/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import Foundation

struct FoodTruckLocation: Codable {
    let latitude: String?
    let longitude: String?
    let human_address: String?
}
struct FoodTruck: Codable {
    let dayorder: String?
    let dayofweekstr: String?
    let starttime: String?
    let endtime: String?
    let permit: String?
    let location: String?
    let locationdesc: String?
    let optionaltext: String?
    let locationid: String?
    let scheduleid: String?
    let start24: String?
    let end24: String?
    let cnn: String?
    let addr_date_create: String?
    let addr_date_modified: String?
    let block: String?
    let lot: String?
    let coldtruck: String?
    let applicant: String?
    let x: String?
    let y: String?
    let latitude: String?
    let longitude: String?
    let location_2: FoodTruckLocation
    let computed_region_rxqg_mtj9: String?
    let computed_region_yftq_j783: String?
    let computed_region_jx4q_fizf: String?
    let computed_region_ajp5_b2md: String?
    let computed_region_bh8s_q3mv: String?

    enum CodingKeys: String, CodingKey {
        case dayorder
        case dayofweekstr
        case starttime
        case endtime
        case permit
        case location
        case locationdesc
        case optionaltext
        case locationid
        case scheduleid
        case start24
        case end24
        case cnn
        case addr_date_create
        case addr_date_modified
        case block
        case lot
        case coldtruck
        case applicant
        case x
        case y
        case latitude
        case longitude
        case location_2
        case computed_region_rxqg_mtj9 = ":@computed_region_rxqg_mtj9"
        case computed_region_yftq_j783 = ":@computed_region_yftq_j783"
        case computed_region_jx4q_fizf = ":@computed_region_jx4q_fizf"
        case computed_region_ajp5_b2md = ":@computed_region_ajp5_b2md"
        case computed_region_bh8s_q3mv = ":@computed_region_bh8s_q3mv"
    }
}

struct FoodTrucks: Codable {
    let foodTrucks : [FoodTruck]
}
