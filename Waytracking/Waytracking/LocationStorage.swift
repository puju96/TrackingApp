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
    }
}
