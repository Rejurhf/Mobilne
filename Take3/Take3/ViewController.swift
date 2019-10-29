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
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // Mark: global variables
    private var currentDate: Date!
    private var minDate: Date!
    private var maxDate: Date!
    
    // Mark: constants
    let DAYS_TO_SHOW = 5
    let WARSAW_WOEID = 523920
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationLabel.text = "Warsaw"
        
        currentDate = Date()
        minDate = currentDate
        maxDate = Calendar.current.date(byAdding: .day, value: DAYS_TO_SHOW, to: minDate)
        updateWeather(date: currentDate)
    }

    // Mark: Buttons action
    @IBAction func previousButtonOnClick(_ sender: UIButton) {
        nextButton.isEnabled = true
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
        updateWeather(date: currentDate)
        if currentDate == minDate {
            previousButton.isEnabled = false
        }
    }
    
    @IBAction func nextButtonOnClick(_ sender: UIButton) {
        previousButton.isEnabled = true
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
        updateWeather(date: currentDate)
        if currentDate == maxDate {
            nextButton.isEnabled = false
        }
    }
    
    // MARK: functions
    func updateWeather(date: Date){
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "dd-MM-yyyy"

        var myString = formatter.string(from: date)
        dateLabel.text = myString
        updateLabels(text: "initial")
    }
    
    func updateLabels(text: String){
        stateLabel.text = text
        minTempLabel.text = text
        maxTempLabel.text = text
        windSpeedLabel.text = text
        windDirectionLabel.text = text
        airPressureLabel.text = text
        humidityLabel.text = text
    }
}

