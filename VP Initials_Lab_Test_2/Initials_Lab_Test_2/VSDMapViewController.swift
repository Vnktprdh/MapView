//
//  ViewController.swift
//  Initials_Lab_Test_2
//
//  Created by Venkat 101287100 on 2021-01-22.
//

import UIKit
import MapKit
import CoreLocation

struct Locations {
    var name : String
    var coordinates : CLLocationCoordinate2D
}


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var Long: UITextField!
    @IBOutlet weak var Lat: UITextField!
    
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.MapView?.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            let InitLocations = [Locations(name: "Home", coordinates: (locationManager.location?.coordinate)!)]
            self.displayMarkers(locations: InitLocations)
           
        }
        
       
        
    }
        


    @IBAction func plotButton(_ sender: Any) {
        
        if(Lat.text == "" || Long.text == "")
        {
            alertBox(title: "Invalid Latitude and Longitude", message: "Please type in correct Latitude and Longitude and Try Again!")
            return
        }
        else{
            getAddress(location: CLLocation(latitude: Double(Lat.text!)!, longitude: Double(Long.text!)!))
        }
        
        
    }
    
}

extension ViewController {
    
    
    func alertBox(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayMarkers(locations : [Locations]){
        
        let allAnnotations = self.MapView.annotations
        self.MapView.removeAnnotations(allAnnotations)
        
        for loc in locations{
            let annotation = MKPointAnnotation()
            annotation.coordinate = loc.coordinates
            annotation.title = loc.name
            self.MapView.addAnnotation(annotation)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func getAddress(location : CLLocation){
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemark, error) in
            self.processGeoResponse(withPlacemarks: placemark, error: error)
        })
    }
    
    func processGeoResponse(withPlacemarks placemarks : [CLPlacemark]?, error : Error?){
        if error != nil{
            print("Unable to find Location")
        }else{
            
            if let placemarks = placemarks, let placemark = placemarks.first{
                let locationArray = [
                    Locations(name: placemark.name!, coordinates: CLLocationCoordinate2D(latitude: (placemark.location?.coordinate.latitude)!, longitude: (placemark.location?.coordinate.longitude)!))]
                       self.displayMarkers(locations: locationArray)
                
            }else{
                print("Address is not found.")
            }
        }
    }
}

