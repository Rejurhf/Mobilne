//
//  Storage.swift
//  CityWeather
//
//  Created by user159552 on 11/4/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Storage {
    static let shared: Storage = Storage()
    
    var objects: [City]
    
    private init(){
        objects = [City]()
    }
}
