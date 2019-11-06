//
//  DetailViewController.swift
//  CityWeather
//
//  Created by Student on 30.10.2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    

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


}

