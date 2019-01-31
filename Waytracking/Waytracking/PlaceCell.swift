//
//  PlaceCell.swift
//  Waytracking
//
//  Created by Apple on 29/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var TitleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func  initData(placeDetail : String , dateString : String)
   {
    TitleLable.text = placeDetail
    dateLable.text = dateString
    
    }

}
