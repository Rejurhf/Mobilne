//
//  CityTableUICell.swift
//  CityWeather
//
//  Created by user159552 on 11/5/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CityTableUICell: UITableViewCell {
    var cityName: String = ""
    var cityWOEID: String = ""
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWOEIDLabel: UILabel!
}
