//
//  SwitchTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

// Cell used for Offering Deal and category filter cells
protocol SwitchCellDelegate: class {
    func isSwitchOn(flag : Bool, object: Dictionary<String, String>, filterParamType: String)
}

class SwitchTableViewCell: UITableViewCell {

    var delegate: SwitchCellDelegate?
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var filterParamType: String? = nil
    
    var myObject : Dictionary<String, String> = [:] {
        didSet {
            nameLabel.text = myObject["name"]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onSwitchValueChanged(_ sender: Any) {
        delegate?.isSwitchOn(flag: mySwitch.isOn, object: myObject , filterParamType: filterParamType!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
