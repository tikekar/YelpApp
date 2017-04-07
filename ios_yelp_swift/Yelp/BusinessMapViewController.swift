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

class BusinessMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mkMapView: MKMapView!
    var locationManager : CLLocationManager!
    
    var business: Business? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()*/
        
        if business != nil {
            navigationItem.title = business?.name
            let centerLocation = CLLocation(latitude: (business?.latitude)!, longitude: (business?.longitude)!)
            goToLocation(location: centerLocation)
            let coordinate = CLLocationCoordinate2DMake((business?.latitude)!, (business?.longitude)!)
            addAnnotationAtCoordinate(coordinate: coordinate)
        }
        
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mkMapView.setRegion(region, animated: false)
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = business?.address
        mkMapView.addAnnotation(annotation)
    }
    
    /*func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mkMapView.setRegion(region, animated: false)
        }
    }*/

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
