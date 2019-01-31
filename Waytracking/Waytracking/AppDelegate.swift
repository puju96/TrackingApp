//
//  AppDelegate.swift
//  Waytracking
//
//  Created by Apple on 29/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import MapKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
static let geoCoder = CLGeocoder()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        center.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
            }
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringVisits()
        locationManager.delegate = self
        
        
        // to enable fake location
        locationManager.distanceFilter = 35
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        
        return true
    }

}

extension AppDelegate : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        
        let cllocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
        // finding location address
        AppDelegate.geoCoder.reverseGeocodeLocation(cllocation) { placeMarks, _  in
            if let place = placeMarks?.first {
                let description = "\(place)"
                self.newVisitReceived(visit, description: description)
            }
        }
    }
    
    func newVisitReceived(_ visit : CLVisit, description: String){
        
        let location = Location(visit: visit, descriptionString: description)
        LocationStorage.shared.saveLocationOnDisk(location)
        
        // sending notification to user
        let content = UNMutableNotificationContent()
        content.title = "New Place entry"
        content.body = location.description
        content.sound = .default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: location.dateString, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            return
        }
        
        AppDelegate.geoCoder.reverseGeocodeLocation(location) { (placemarks, _) in
            
            let place = placemarks?.first
            
            let description = "Fake Visit : \(place)"
            
            let fakeVisit = FakeVisit(coordinate: location.coordinate, arrivalDate: Date(), departureDate: Date())
            
            self.newVisitReceived(fakeVisit, description: description)
        }
    }
    
}

final class FakeVisit : CLVisit {
    
    private let myCoordinate : CLLocationCoordinate2D
    private let myArrivalDate : Date
    private let myDepartureDate :Date
    
    
    override var coordinate: CLLocationCoordinate2D {
        return myCoordinate
    }
    
    override var arrivalDate: Date{
        return myArrivalDate
    }
    override var departureDate: Date{
        return myDepartureDate
    }
    
    init(coordinate : CLLocationCoordinate2D , arrivalDate : Date,departureDate: Date) {
        myCoordinate = coordinate
        myArrivalDate = arrivalDate
        myDepartureDate = departureDate
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
