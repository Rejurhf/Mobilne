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
    
    @IBOutlet weak var stateImage: UIImageView!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: City? {
        didSet {
            // Update the view.
            configureView()
        }
    }


    @IBAction func onClickPreviousButton(_ sender: UIButton) {
    }
    
    
    @IBAction func onClickNextButton(_ sender: UIButton) {
    }
}

