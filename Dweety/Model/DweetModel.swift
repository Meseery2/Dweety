//
//  DweetModel.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Foundation

struct DweetModel: Codable {
    var thing : String?
    var content : DweetData?
}


struct DweetData : Codable {
    var accelerometerData : DweetAccelerometerData?
    var deviceLocation : String?
    var deviceName : String?
    var temperature : Double?
    var temperatureUnit : String?
    
    enum CodingKeys: String, CodingKey {
        case accelerometerData  = "accelerometer_data"
        case deviceLocation     = "device_location"
        case deviceName         = "device_name"
        case temperature        = "temperature_data"
        case temperatureUnit    = "temperature_unit"
    }
}

struct DweetAccelerometerData : Codable {
    var x,y,z : Double?
}
