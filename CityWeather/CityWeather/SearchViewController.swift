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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickSubmitButton(_ sender: UIButton) {
        let newCityName = cityInputText.text!
        let newCityWOEID = "1234"
        
        let newCity = City(cityName: newCityName, cityWOEID: newCityWOEID)
        
        Storage.shared.objects.append(newCity)
        
        performSegue(withIdentifier: "backToTable", sender: self)
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
