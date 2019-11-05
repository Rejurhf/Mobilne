//
//  City.swift
//  CityWeather
//
//  Created by user159552 on 11/4/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class City{
    var cityName:String
    var cityWOEID:String
    
    init(cityName:String, cityWOEID:Int){
        self.cityName = cityName
        self.cityWOEID = "\(cityWOEID)"
    }
}
