//
//  Weatherman.swift
//  CityWeather
//
//  Created by user159552 on 11/6/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit

let METAWEATHER_API_BASE = "https://www.metaweather.com/"
let METAWEATHER_API_SEARCH = "api/location/search/?query="
let METAWEATHER_API_WEATHER = "api/location/"
let METAWEATHER_API_IMAGE = "static/img/weather/png/"

func createWeatherReport(locationName: String, woeid: Int,
                         date: Date, callback: @escaping (City) -> Void) {
    var weatherReport = City(cityName: locationName, cityWOEID: "\(woeid)")
//    weatherReport.locationName = locationName
//    weatherReport.woeid = woeid
    weatherReport.date = date
    fetchWeatherData(weatherReport: weatherReport, callback: callback)
}

func fetchWeatherData(weatherReport: City, callback: @escaping (City) -> Void) {
    let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: weatherReport.date!)
    let dateText = "\(String(describing: dateComponents.year!))/\(String(describing: dateComponents.month!))/\(String(describing: dateComponents.day!))"
    let requestUrl = METAWEATHER_API_BASE + METAWEATHER_API_WEATHER + weatherReport.cityWOEID + dateText
    var weatherData: [String: AnyObject] = [:]
    if let url = URL(string: requestUrl) {
        _ = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { (data, _, _) -> Void in
            guard let data = data else { return }
            DispatchQueue.main.async {
                let deserializedData = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
                weatherData = deserializedData![0]
                var partialReport = weatherReport
                partialReport.weatherStateAbbreviation = String(weatherData["weather_state_abbr"] as! NSString)
                partialReport.temperature = Int(truncating: weatherData["the_temp"] as! NSNumber)
                partialReport.humidity = Int(truncating: weatherData["humidity"] as! NSNumber)
                partialReport.windSpeed = Int(truncating: weatherData["wind_speed"] as! NSNumber)
                partialReport.windDirection = String(weatherData["wind_direction_compass"] as! NSString)
                partialReport.airPressure = Int(truncating: weatherData["air_pressure"] as! NSNumber)
                fetchWeatherStateIcon(weatherReport: partialReport, callback: callback)
            }
        }).resume()
    }
}

func fetchWeatherStateIcon(weatherReport: City, callback: @escaping (City) -> Void) {
    let imageRequestUrl = METAWEATHER_API_BASE + METAWEATHER_API_IMAGE + weatherReport.weatherStateAbbreviation! + ".png"
    if let imageUrl = URL(string: imageRequestUrl) {
        _ = URLSession.shared.dataTask(with: URLRequest(url: imageUrl), completionHandler: { (data, _, _) -> Void in
            guard let data = data else { return }
            DispatchQueue.main.async {
                var completeReport = weatherReport
                completeReport.weatherStateIcon = UIImage(data: data)
                callback(completeReport)
            }
        }).resume()
    }
}
