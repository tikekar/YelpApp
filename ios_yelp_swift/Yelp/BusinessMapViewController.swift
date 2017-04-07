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

class BusinessMapViewController: UIViewController {

    @IBOutlet weak var mkMapView: MKMapView!
    
    //var business: Business? = nil
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
        annotation.title = business.address! + ", " + business.city!
        mkMapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
