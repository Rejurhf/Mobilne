//
//  SearchViewController.swift
//  CityWeather
//
//  Created by Student on 30.10.2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var cityInputText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.isEnabled = false
        
        cityInputText.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickSubmitButton(_ sender: UIButton) {
        let newCityName = cityInputText.text!
        let newCityWOEID = "523920"
        
        createWeatherReport(locationName: "Warsaw", woeid: 523920, date: Date(), callback: { (weatherReport) in
            Storage.shared.objects.append(weatherReport)
        })
        
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
