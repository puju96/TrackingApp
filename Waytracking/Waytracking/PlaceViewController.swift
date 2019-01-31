//
//  FirstViewController.swift
//  Waytracking
//
//  Created by Apple on 29/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(newLocationSaved(_ :)), name: .newLocationSaved, object: nil)
        
    }
    @objc func newLocationSaved(_ notification : Notification) {
        TableView.reloadData()
        
    }
    
}

extension PlaceViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationStorage.shared.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceCell else { return UITableViewCell()}
        let location = LocationStorage.shared.locations[indexPath.row]
        
         
        
        cell.initData(placeDetail: location.description, dateString: location.dateString)
        return cell
       
    }
    
    
}

