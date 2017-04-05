//
//  DistancesTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/5/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DistancesTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    var meterValue : String = ""
    
    var distanceObject : Dictionary<String, String> = [:] {
        didSet {
            let keys_ = distanceObject.keys
            let key_ = Array(keys_)[0]
            distanceLabel.text = key_
            meterValue = distanceObject[key_]!
            
            selectionLabel.text = ""
            selectionLabel.layer.borderWidth = 1
            selectionLabel.layer.borderColor = UIColor.lightGray.cgColor
            selectionLabel.textColor = UIColor.darkGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionLabel.layer.cornerRadius = selectionLabel.frame.size.width/2
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
