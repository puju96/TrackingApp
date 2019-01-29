//
//  SecondViewController.swift
//  Waytracking
//
//  Created by Apple on 29/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapview.userTrackingMode = .follow
    }

    @IBAction func addLocationTapped(_ sender: Any) {
    }
    
}

