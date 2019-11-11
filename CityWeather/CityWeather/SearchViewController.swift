//
//  SearchViewController.swift
//  CityWeather
//
//  Created by Student on 30.10.2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var cityInputText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var currLocation: UILabel!
    let list = ["Warsaw"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.isEnabled = false
        currLocation.text = "You are currently in: Krakow, Poland"
        cityInputText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickSubmitButton(_ sender: UIButton) {
        let newCityName = cityInputText.text!
//        let newCityWOEID = "523920"
        
        if newCityName == "London"{
            createWeatherReport(locationName: "London", woeid: 44418, date: Date(), callback: { (weatherReport) in
                Storage.shared.objects.append(weatherReport)
            })
        }else if newCityName == "San Francisco"{
            createWeatherReport(locationName: "San Francisco", woeid: 2487956, date: Date(), callback: { (weatherReport) in
                Storage.shared.objects.append(weatherReport)
            })
        }else{
            createWeatherReport(locationName: "Warsaw", woeid: 523920, date: Date(), callback: { (weatherReport) in
                Storage.shared.objects.append(weatherReport)
            })
        }
        
        
//        let newCity = City(cityName: newCityName, cityWOEID: newCityWOEID)
//
//        Storage.shared.objects.append(newCity)
        
        performSegue(withIdentifier: "backToTable", sender: self)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        guard
            let name = cityInputText.text, !name.isEmpty
            else {
                self.submitButton.isEnabled = false
                return
        }
        submitButton.isEnabled = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
