//
//  OfferingDealTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/4/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

protocol OfferingDealDelegate: class {
    func isDealSwitchOn(flag : Bool)
}

// Cell for Offering Deal cell
// TODO: Merge it with Categories Cell
class OfferingDealTableViewCell: UITableViewCell {

    var delegate: OfferingDealDelegate?
    
    @IBOutlet weak var dealSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func onSwitchValueChanged(_ sender: Any) {
        delegate?.isDealSwitchOn(flag: dealSwitch.isOn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
