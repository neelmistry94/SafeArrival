//
//  ViewController.swift
//  SafeArrival
//
//  Created by Neel Mistry on 11/27/15.
//  Copyright (c) 2015 Neel Mistry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var SearchBar: UITextField!
    
    var locationManager = CLLocationManager()
    var matchingItems: NSMutableArray = []
    var currentDestination: NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setAppTitle()
        setCurrentLocation()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setAppTitle(){
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        var titleLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.navigationController!.navigationBar.frame.size.width, self.navigationController!.navigationBar.frame.size.height))
        titleLabel.text = "Safe Arrival"
        titleLabel.font = UIFont(name: "Helvetica", size: 50.0)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = titleLabel

    }
    
    func setCurrentLocation(){
        MapView.showsUserLocation = true
        MapView.mapType = MKMapType(rawValue: 0)!
        MapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
    }

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            MapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func textFieldDidReturn(sender: AnyObject) {
        sender.resignFirstResponder()
        for pin:MKAnnotation in self.MapView.annotations as! [MKAnnotation] {
            self.MapView.removeAnnotation(pin)
        }
        performSearch()
    }
    
    func performSearch() {
        var searchRequest: MKLocalSearchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = SearchBar.text
        currentDestination = SearchBar.text
        searchRequest.region = MapView.region
        
        var search: MKLocalSearch = MKLocalSearch(request: searchRequest)
        
        search.startWithCompletionHandler { (response:MKLocalSearchResponse!, error:NSError!) in
            if (response.mapItems.count == 0 || response == nil) {
                println("No Matches")
            }
            else {
                for item: MKMapItem in response.mapItems as! [MKMapItem] {
                    self.matchingItems.addObject(item)
                    var pointAnnotation: MKPointAnnotation = MKPointAnnotation()
                    pointAnnotation.title = "Confirm Destination"
                    pointAnnotation.coordinate = item.placemark.coordinate
                    self.MapView.centerCoordinate = pointAnnotation.coordinate
                    self.MapView.addAnnotation(pointAnnotation)
                }
            }
        }
    }
}