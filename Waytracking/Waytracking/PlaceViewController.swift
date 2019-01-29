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
        
    }
}

extension PlaceViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceCell else { return UITableViewCell()}
        return cell
       
    }
    
    
}

