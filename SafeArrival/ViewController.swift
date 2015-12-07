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

var currentDestination: NSString = ""
var loadedOnce = false

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var MapView: MKMapView!{
        didSet{
            MapView.delegate = self
        }
    }
    
    @IBOutlet weak var SearchBar: UITextField!
    @IBOutlet weak var ContactsBtn: UIButton!
    @IBOutlet weak var MessagesBtn: UIButton!
    @IBOutlet weak var SettingsBtn: UIButton!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formatButtons()
        setCurrentLocation()
        
        // Only load defaults once
        if (!loadedOnce){
            loadDefaultMessages()
            loadDefaultGroup()
            loadContacts()
            loadedOnce = true
        }

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setCurrentLocation(){
        MapView.showsUserLocation = true
        MapView.mapType = MKMapType(rawValue: 0)!
        MapView.userTrackingMode = MKUserTrackingMode(rawValue: 1)!
    }
    
    func loadDefaultMessages(){
        let m1 = Message(name: "Safe Message", contents: "Hey I got to my destination safe and sound")!
        
        messages += [m1]
    }
    func loadDefaultGroup(){
        
        let g1 = ContactGroup(name: "Parents", contents: ["Mom", "Dad"])!
        
        contactGroups += [g1]
    }
    
    func loadContacts(){
        let c1 = "Dad"
        let c2 = "Mom"
        let c3 = "Sister"
        let c4 = "Brother A"
        let c5 = "Brother B"
        let c6 = "Friend A"
        let c7 = "Ex"
        let c8 = "Friend B"
        let c9 = "Collegue"
        let c10 = "Lover"
        
        contacts += [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10]
        
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
        for pin:MKAnnotation in self.MapView.annotations as [MKAnnotation] {
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
                for item: MKMapItem in response.mapItems as [MKMapItem] {
                    var annotationView: MKAnnotationView = MKAnnotationView()
                    var pointAnnotation: MKPointAnnotation = MKPointAnnotation()
                    pointAnnotation.title = "Confirm Destination"
                    pointAnnotation.coordinate = item.placemark.coordinate
                    self.MapView.centerCoordinate = pointAnnotation.coordinate
                    self.MapView.addAnnotation(pointAnnotation)
                    self.MapView.selectAnnotation(pointAnnotation, animated: true)
                    
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegion(center: pointAnnotation.coordinate, span: span)
                    self.MapView.setRegion(region, animated: true)
                }
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("AnnotationView Id")
        
        // User location pin
        var view2 = mapView.dequeueReusableAnnotationViewWithIdentifier(nil)
        
        var pinLoc = annotation.coordinate
        var userLoc = mapView.userLocation.coordinate
        
        // Check if the pin we're loading is the userLocation
        if (pinLoc.latitude == userLoc.latitude && pinLoc.longitude == userLoc.longitude){
            return view2;
        }
        
        if view == nil{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView Id")
            view!.canShowCallout = true
        } else {
            view!.annotation = annotation
        }
        
        var confirmBtn: UIButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton

        view?.rightCalloutAccessoryView = confirmBtn
        
        return view
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        mapView.deselectAnnotation(view.annotation, animated: false)
        performSegueWithIdentifier("Summary Page", sender: self)
    }
    
    func formatButtons(){
        ContactsBtn.layer.borderColor = UIColor.blackColor().CGColor
        ContactsBtn.layer.borderWidth = 3
        ContactsBtn.layer.cornerRadius = 5
        
        MessagesBtn.layer.borderColor = UIColor.blackColor().CGColor
        MessagesBtn.layer.borderWidth = 3
        MessagesBtn.layer.cornerRadius = 5
        
        SettingsBtn.layer.borderColor = UIColor.blackColor().CGColor
        SettingsBtn.layer.borderWidth = 3
        SettingsBtn.layer.cornerRadius = 5
    }
    
}