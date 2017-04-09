//
//  ExpandTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class ExpandTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    var cellObject : Dictionary<String, String> = [:] {
        didSet {
            nameLabel.text = cellObject["name"]
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
