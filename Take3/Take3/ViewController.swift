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
    @IBOutlet weak var weatherStateImage: UIImageView!
    
    
    // Mark: global variables
    private var currentDate: Date!
    private var minDate: Date!
    private var maxDate: Date!
    
    // Mark: constants
    let DAYS_TO_SHOW = 5
    let WARSAW_WOEID = 523920
    let METAWEATHER_URL = "https://www.metaweather.com/"
    let METAWEATHER_WOEID_QUERY = "api/location/search/?query="
    let METAWEATHER_WEATHER_QUERY = "api/location/"
    let METAWEATHER_IMAGE_QUERY = "static/img/weather/png/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
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
        let myString = formatter.string(from: date)
        dateLabel.text = myString
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let weatherRequestUrl = METAWEATHER_URL + METAWEATHER_WEATHER_QUERY + "\(WARSAW_WOEID)/\(dateComponents.year!)/\(dateComponents.month!)/\(dateComponents.day!)"
        if let weatherUrl = URL(string: weatherRequestUrl) {
            _ = URLSession.shared.dataTask(with: URLRequest(url: weatherUrl), completionHandler: { (data, _, _) -> Void in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let deserializedData = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
                    let weatherData = deserializedData![0]
                    self.updateLabels(weatherDict: weatherData)
                    let weatherStateAbbreviation = String(weatherData["weather_state_abbr"] as! NSString)
                    let imageRequestUrl = self.METAWEATHER_URL + self.METAWEATHER_IMAGE_QUERY + weatherStateAbbreviation + ".png"
                    if let imageUrl = URL(string: imageRequestUrl) {
                        _ = URLSession.shared.dataTask(with: URLRequest(url: imageUrl), completionHandler: { (data, _, _) -> Void in
                            guard let data = data else { return }
                            DispatchQueue.main.async {
                                self.weatherStateImage.image = UIImage(data: data)
                            }
                        }).resume()
                    }
                }
            }).resume()
        }
    }
    
    func updateLabels(weatherDict: [String: AnyObject]){
        stateLabel.text = String(weatherDict["weather_state_name"] as! NSString)
        minTempLabel.text = String(Int(truncating: weatherDict["min_temp"] as! NSNumber)) + "°C"
        maxTempLabel.text = String(Int(truncating: weatherDict["max_temp"] as! NSNumber)) + "°C"
        windSpeedLabel.text = String(Int(truncating: weatherDict["wind_speed"] as! NSNumber)) + " mph"
        windDirectionLabel.text = String(weatherDict["wind_direction_compass"] as! NSString)
        airPressureLabel.text = String(Int(truncating: weatherDict["air_pressure"] as! NSNumber)) + " mbar"
        humidityLabel.text = String(Int(truncating: weatherDict["humidity"] as! NSNumber)) + "%"
    }
}

