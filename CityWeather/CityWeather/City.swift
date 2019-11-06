//
//  City.swift
//  CityWeather
//
//  Created by user159552 on 11/4/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit

class City{
    var cityName:String
    var cityWOEID:String
    
    var date: Date?
    
    var weatherStateAbbreviation: String?
    var weatherStateIcon: UIImage?
    
    var temperature: Int?
    var humidity: Int?
    var windSpeed: Int?
    var windDirection: String?
    var airPressure: Int?
    
    init(cityName:String, cityWOEID:String){
        self.cityName = cityName
        self.cityWOEID = cityWOEID
    }
}
