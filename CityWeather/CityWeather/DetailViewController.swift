//
//  DetailViewController.swift
//  CityWeather
//
//  Created by Student on 30.10.2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var airPresureLabel: UILabel!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var stateImage: UIImageView!
    
    let DISPLAYABLE_DAYS = 7
    
    var locationName: String! = ""
    var woeid: Int! = 0
    var displayedDate: Date! = Date()
    var displayedDayNumber = 0
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            displayedDate = detail.date!
            locationName = detail.cityName
            woeid = Int(detail.cityWOEID)
            updateView(weatherReport: detail)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        locationLabel.text = locationName
    }

    var detailItem: City? {
        didSet {
            // Update the view.
            configureView()
        }
    }


    @IBAction func onClickPreviousButton(_ sender: UIButton) {
        nextButton.isEnabled = true
        displayedDayNumber -= 1
        displayedDate = Calendar.current.date(byAdding: .day, value: -1, to: displayedDate)
        createWeatherReport(locationName: locationName, woeid: woeid, date: displayedDate, callback: { (weatherReport) in
            self.updateView(weatherReport: weatherReport)
        })
        if displayedDayNumber <= 0 {
            previousButton.isEnabled = false
        }
    }
    
    
    @IBAction func onClickNextButton(_ sender: UIButton) {
        previousButton.isEnabled = true
        displayedDayNumber += 1
        displayedDate = Calendar.current.date(byAdding: .day, value: 1, to: displayedDate)
        createWeatherReport(locationName: locationName, woeid: woeid, date: displayedDate, callback: { (weatherReport) in
            self.updateView(weatherReport: weatherReport)
        })
        if displayedDayNumber >= DISPLAYABLE_DAYS - 1 {
            nextButton.isEnabled = false
        }
    }
    
    func updateView(weatherReport: City) {
        if let label = dateLabel {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: weatherReport.date!)
            label.text = "\(String(describing: dateComponents.day!))/\(String(describing: dateComponents.month!))/\(String(describing: dateComponents.year!))"
        }
        if let label = temperatureLabel {
            label.text = "\(String(describing: weatherReport.temperature!)) °C"
        }
        if let label = humidityLabel {
            label.text = "\(String(describing: weatherReport.humidity!))%"
        }
        if let label = windSpeedLabel {
            label.text = "\(String(describing: weatherReport.windSpeed!)) mph"
        }
        if let label = windDirectionLabel {
            label.text = "\(String(describing: weatherReport.windDirection!))"
        }
        if let label = airPresureLabel {
            label.text = "\(String(describing: weatherReport.airPressure!)) mbar"
        }
        if let view = stateImage {
            view.image = weatherReport.weatherStateIcon!
        }
        if let label = weatherLabel {
            label.text = "\(String(describing: weatherReport.weatherStateAbbreviation!))"
        }
    }
}

