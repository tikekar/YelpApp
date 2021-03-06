//
//  Business.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

let OFFSET_PARAM = "offset"
let TERM_FILTER = "term"

class Business: NSObject {
    let name: String?
    let address: String?
    var city: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?
    var latitude: Double! = 0
    var longitude: Double! = 0
    var mobileURL: URL?
    
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let mobileUrlString = dictionary["mobile_url"] as? String
        if mobileUrlString != nil {
            mobileURL = URL(string: mobileUrlString!)!
        } else {
            mobileURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        city = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let city_ = location!["city"] as? String
            if city_ != nil {
                city = city_
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
            let coordinate_ = location!["coordinate"] as? NSDictionary
            if coordinate_ != nil {
                latitude = (coordinate_?["latitude"] as! Double)
                longitude = (coordinate_?["longitude"] as! Double)
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)
    }
    
    class func searchWithParameters(parameters: Dictionary<String, Any>, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        // Need this because parameters is a let kind and cannot be modified
        var modifiableParameters : Dictionary = parameters
        if modifiableParameters[LAT_LONG_FILTER] == nil {
            modifiableParameters[LAT_LONG_FILTER] = "37.785771,-122.406165" as AnyObject?
        }
        if modifiableParameters[CATEGORY_FILTER] != nil {
            modifiableParameters[CATEGORY_FILTER] = modifiableParameters[CATEGORY_FILTER] as AnyObject?
        }

        _ = YelpClient.sharedInstance.searchWithParameters(modifiableParameters, completion: completion)
    }
}
