//
//  MapViewController.swift
//  CityWeather
//
//  Created by user159552 on 11/11/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController{
    
//    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let annontation = MKPointAnnotation()
        annontation.coordinate = CLLocationCoordinate2D(latitude: 52.235352, longitude: 21.009390)
        mapView.addAnnotation(annontation)
    }
    
//    @IBAction func backButtonOnClick(_ sender: UIButton) {
//        performSegue(withIdentifier: "goBackFromMap", sender: self)
//    }
}
