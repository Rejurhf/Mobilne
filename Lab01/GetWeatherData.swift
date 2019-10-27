import Foundation
import FoundationNetworking

var jsonWeather = ""
if let url = URL(string: "https://www.metaweather.com/api/location/523920/") {
    do {
        jsonWeather = try String(contentsOf: url)
    } catch {
        print("Error ocured while loading data")
    }
} else {
    print("Wrong URL")
}

// print(jsonWeather)
var dataTmp = "[" + jsonWeather + "]"
let data = dataTmp.data(using: .utf8)!
var jsonArray: [Dictionary<String, Any>] = [] 

if let tmpJsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
{
    jsonArray = tmpJsonArray
    // use the json here     
} else {
    print("bad json")
}

// print(type(of: jsonArray))\(jsonArray)\(jsonArray[0])
var info = (jsonArray[0]["consolidated_weather"] as? [Dictionary<String, Any>])!

print("Warunki: \(info[0]["weather_state_name"]!)\nTemp min: \(info[0]["min_temp"]!) [C]\n" +
    "Temp max: \(info[0]["max_temp"]!) [C]\nPrędkość wiatru: \(info[0]["wind_speed"]!) [mph]\n" +
    "Kierunek wiatru: \(info[0]["wind_direction_compass"]!)\n" +
    "Opady: \(info[0]["humidity"]!) [%]\nCiśnienie: \(info[0]["air_pressure"]!) [mbar]")