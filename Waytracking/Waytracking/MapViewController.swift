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
        
        let annotations = LocationStorage.shared.locations.map{annotationForLocation($0)}
        mapview.addAnnotations(annotations)
        
        NotificationCenter.default.addObserver(self, selector: #selector(newLocationStarted(_:)), name: .newLocationSaved, object: nil)
    }

    @IBAction func addLocationTapped(_ sender: Any) {
        
        guard let currentLocation = mapview.userLocation.location else {return}
        
        LocationStorage.shared.saveCLLocationOnDisk(currentLocation)
    }
    
    func annotationForLocation(_ location : Location) -> MKAnnotation{
        let annotation = MKPointAnnotation()
        annotation.title = location.dateString
        annotation.coordinate = location.coordinates
        return annotation
        
    }
    
   @objc func newLocationStarted(_ notification : Notification) {
        guard let location = notification.userInfo?["location"] as? Location else {
            return
        }
        
        let annotation  = annotationForLocation(location)
        mapview.addAnnotation(annotation)
        
    }
    
}

