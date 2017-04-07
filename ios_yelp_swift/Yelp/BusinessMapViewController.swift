//
//  BusinessMapViewController.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Show one more more address pins on the map.
class BusinessMapViewController: UIViewController {

    @IBOutlet weak var mkMapView: MKMapView!
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if businesses != nil && businesses.count > 0 {
            if businesses.count == 1 {
                navigationItem.title = businesses[0].name
            }
            for i in 0...businesses.count - 1 {
                let business = businesses[i]
                if i == 0 {
                    let centerLocation = CLLocation(latitude: (business.latitude)!, longitude: (business.longitude)!)
                    goToLocation(location: centerLocation)
                }
                addAnnotationAtCoordinate(business: business)
            }
        }
        
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mkMapView.setRegion(region, animated: false)
    }
    
    func addAnnotationAtCoordinate(business: Business) {
        let coordinate = CLLocationCoordinate2DMake((business.latitude)!, (business.longitude)!)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = business.name
        annotation.subtitle = business.address! + ", " + business.city!
        mkMapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
