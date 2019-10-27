//
//  ViewController.swift
//  Take2
//
//  Created by user159552 on 10/27/19.
//  Copyright © 2019 user159552. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let METAWEATHER_API_BASE = "https://www.metaweather.com/"
    let METAWEATHER_API_SEARCH = "api/location/search/?query="
    let METAWEATHER_API_WEATHER = "api/location/"
    let METAWEATHER_API_IMAGE = "static/img/weather/png/"
    
    let WOEID_WARSAW = 523920
    
    let DISPLAYABLE_DAYS = 7

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var airPresureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var localisationLabel: UILabel!
    
    private var smallestDisplayableDate: Date!
    private var currentlyDisplayedDate: Date!
    private var biggestDisplayableDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentlyDisplayedDate = Date()
        smallestDisplayableDate = currentlyDisplayedDate
        biggestDisplayableDate = Calendar.current.date(byAdding: .day, value: DISPLAYABLE_DAYS, to: smallestDisplayableDate)
        localisationLabel.text = "Warsaw"
        updateWeatherGivenWoeidAndDate(woeid: WOEID_WARSAW, date: currentlyDisplayedDate)
    }
    
    
    func updateWeatherGivenWoeidAndDate(woeid: Int, date: Date) {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateLabel.text = "\(dateComponents.year!)/\(dateComponents.month!)/\(dateComponents.day!)"
        let weatherRequestUrl = METAWEATHER_API_BASE + METAWEATHER_API_WEATHER + "\(woeid)/\(dateComponents.year!)/\(dateComponents.month!)/\(dateComponents.day!)"
        if let weatherUrl = URL(string: weatherRequestUrl) {
            _ = URLSession.shared.dataTask(with: URLRequest(url: weatherUrl), completionHandler: { (data, _, _) -> Void in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let deserializedData = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
                    let weatherData = deserializedData![0]
                    self.updateLabels(data: weatherData)
                    let weatherStateAbbreviation = String(weatherData["weather_state_abbr"] as! NSString)
                    let imageRequestUrl = self.METAWEATHER_API_BASE + self.METAWEATHER_API_IMAGE + weatherStateAbbreviation + ".png"
                    if let imageUrl = URL(string: imageRequestUrl) {
                        _ = URLSession.shared.dataTask(with: URLRequest(url: imageUrl), completionHandler: { (data, _, _) -> Void in
                            //guard let data = data else { return }
                            //DispatchQueue.main.async {
                            //    self.weatherStateImage.image = UIImage(data: data)
                            //}
                        }).resume()
                    }
                }
            }).resume()
        }
    }

    func updateLabels(data: [String: AnyObject]) {
        stateLabel.text = "custom state"//String(data["weather_state_name"] as! NSString)
        minTempLabel.text = "°C"//String(Int(truncating: data["the_temp"] as! NSNumber)) + "°C"
        maxTempLabel.text = "°C"//String(Int(truncating: data["the_temp"] as! NSNumber)) + "°C"
        windSpeedLabel.text = "mph" //String(Int(truncating: data["wind_speed"] as! NSNumber)) + " mph"
        windDirectionLabel.text = "direction" //String(data["wind_direction_compass"] as! NSString)
        airPresureLabel.text = "mbar" //String(Int(truncating: data["air_pressure"] as! NSNumber)) + " mbar"
        rainLabel.text = "%"//String(Int(truncating: data["humidity"] as! NSNumber)) + "%"
    }
}

