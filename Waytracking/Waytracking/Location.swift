//
//  Location.swift
//  Waytracking
//
//  Created by Apple on 29/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import CoreLocation

class Location : Codable
{
    static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
        }()
    


var coordinates : CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
}

let latitude: Double
let longitude: Double
let date : Date
let dateString : String
let description: String

init(_ location: CLLocationCoordinate2D, date: Date,descriptionString :String){
    
    latitude = location.latitude
    longitude = location.longitude
    self.date = date
    description = descriptionString
    dateString = Location.dateFormatter.string(from: date)
}

    convenience init(visit : CLVisit , descriptionString: String){
        self.init(visit.coordinate, date : visit.arrivalDate, descriptionString : descriptionString)
    }
    
}
