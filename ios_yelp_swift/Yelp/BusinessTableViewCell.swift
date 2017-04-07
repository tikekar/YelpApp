//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/4/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    var business: Business! {
        didSet {
            businessNameLabel.text = business.name
            addressLabel.text = business.address! + ", " + business.city!
            distanceLabel.text = business.distance
            categoryLabel.text = business.categories
            reviewsCountLabel.text = business.reviewCount?.stringValue
            
            if business.imageURL != nil {
                businessImageView.setImageWith(business.imageURL!)
            }
            if business.ratingImageURL != nil {
                ratingsImageView.setImageWith(business.ratingImageURL!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        businessImageView.layer.cornerRadius = 4
        businessNameLabel.preferredMaxLayoutWidth = distanceLabel.frame.origin.x - businessNameLabel.frame.origin.x - 20
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        businessNameLabel.preferredMaxLayoutWidth = distanceLabel.frame.origin.x - businessNameLabel.frame.origin.x - 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
