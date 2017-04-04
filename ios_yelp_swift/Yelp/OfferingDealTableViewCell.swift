//
//  OfferingDealTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/4/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class OfferingDealTableViewCell: UITableViewCell {

    
    @IBOutlet weak var borderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
