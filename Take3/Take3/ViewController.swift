//
//  ViewController.swift
//  Take3
//
//  Created by user159552 on 10/29/19.
//  Copyright © 2019 user159552. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: UIvariables
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var airPressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Mark: Buttons action
    @IBAction func previousButtonOnClick(_ sender: UIButton) {
        locationLabel.text = "Previosu"
        dateLabel.text = "Previosu"
        stateLabel.text = "Previosu"
        minTempLabel.text = "Previosu"
        maxTempLabel.text = "Previosu"
        windSpeedLabel.text = "Previosu"
        windDirectionLabel.text = "Previosu"
        airPressureLabel.text = "Previosu"
        humidityLabel.text = "Previosu"
    }
    
    @IBAction func nextButtonOnClick(_ sender: UIButton) {
        locationLabel.text = "Next"
        dateLabel.text = "Next"
        stateLabel.text = "Next"
        minTempLabel.text = "Next"
        maxTempLabel.text = "Next"
        windSpeedLabel.text = "Next"
        windDirectionLabel.text = "Next"
        airPressureLabel.text = "Next"
        humidityLabel.text = "Next"
    }
    
}

