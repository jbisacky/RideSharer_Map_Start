//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            checkLocationAuthorization()
            
        } else {
            showLocationNeededPopup()
        }
        
    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
          mapView.showsUserLocation = true
        case .denied:
            showLocationNeededPopup()
          break
        case .notDetermined:
          locationManager.requestWhenInUseAuthorization()
          mapView.showsUserLocation = true
        case .restricted:
          break
        case .authorizedAlways:
          break
        }
    }
    func showLocationNeededPopup() {
        let alert = UIAlertController(title: "Location Needed", message: "You have not provided permission for location.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            showLocationNeededPopup()
        }
    }
}

