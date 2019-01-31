//
//  LocationStorage.swift
//  Waytracking
//
//  Created by Apple on 29/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import CoreLocation

class LocationStorage {
    static let shared = LocationStorage()
    
    private(set) var locations : [Location]
    private let filemanager: FileManager
    private let documentURL: URL
    
    init() {
        
        let filemanager = FileManager.default
        documentURL =  try! filemanager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.filemanager = filemanager
        self.locations = []
        
        let jsonDecoder = JSONDecoder()
        
        let locationFileURLs = try! filemanager.contentsOfDirectory(at: documentURL, includingPropertiesForKeys: nil)
        
        locations = locationFileURLs.compactMap({ (url) -> Location? in
            
            guard  !url.absoluteString.contains("DS_Store") else {
                return nil
            }
            
            guard let data = try? Data(contentsOf: url) else {
                return nil
            }
            
          return try! jsonDecoder.decode(Location.self, from: data)
            
        }).sorted(by: {$0.date < $1.date})
        
        
    }
    
    
    func saveLocationOnDisk(_ location : Location) {
        
        let encoder = JSONEncoder()
        let timestamp = location.date.timeIntervalSince1970
        
        let fileURL = documentURL.appendingPathComponent("\(timestamp)")
        
      let data =  try! encoder.encode(location)
        
       try! data.write(to: fileURL)
        
        locations.append(location)
    }
    
    func saveCLLocationOnDisk(_ cllocation : CLLocation){
        
        let currentDate = Date()
        
        AppDelegate.geoCoder.reverseGeocodeLocation(cllocation) { (placemarks, error) in
            
            let place = placemarks?.first
            
            let location = Location(cllocation.coordinate, date: currentDate, descriptionString: "\(place)")
            
            self.saveLocationOnDisk(location)
        }
        
        
    }
}
