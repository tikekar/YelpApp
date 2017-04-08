//
//  DistancesTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/5/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

// Cell for Distance cell in FilterView
// TODO: Merge it with SortBy Cell
class DistancesTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    var distanceObject : Dictionary<String, String> = [:] {
        didSet {
            distanceLabel.text = distanceObject["name"]
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
