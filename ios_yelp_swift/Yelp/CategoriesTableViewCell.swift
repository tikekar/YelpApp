//
//  CategoriesTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

protocol CategoriesCellDelegate: class {
    func isCategorySwitchOn(flag : Bool, categoryObject: Dictionary<String, String>)
}

// Cell for Categories cell in FilterView
// TODO: Merge it with Deal Cell
class CategoriesTableViewCell: UITableViewCell {

    var delegate: CategoriesCellDelegate?
    
    @IBOutlet weak var dealSwitch: UISwitch!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var categoryObject : Dictionary<String, String> = [:] {
        didSet {
            categoryLabel.text = categoryObject["name"]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onSwitchValueChanged(_ sender: Any) {
        delegate?.isCategorySwitchOn(flag: dealSwitch.isOn, categoryObject: categoryObject)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
