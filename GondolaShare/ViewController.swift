//
//  ViewController.swift
//  GondolaShare
//
//  Created by SEIF EL FREJ ISMAIL on 17/03/2019.
//  Copyright © 2019 SEIF EL FREJ ISMAIL. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation





class gondolaStations: NSObject, MKAnnotation, UIGestureRecognizerDelegate {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String ){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle

        super.init()
    }
}



// Set location,title and subtitle of gondola stops
let accademiaStopCoordinate = CLLocationCoordinate2D(latitude: 45.43171, longitude: 12.328415)
let santaBarnabaStopCoordinate = CLLocationCoordinate2D(latitude: 45.433172, longitude: 12.324826)
let santaMariaDelGiglioStopCoordinate = CLLocationCoordinate2D(latitude: 45.431672, longitude: 12.333016)
let BauerStopCoordinate = CLLocationCoordinate2D(latitude: 45.432973, longitude: 12.335466)
let puntaDellaDoganaStopCoordinate = CLLocationCoordinate2D(latitude: 45.432354, longitude: 12.337186) //,
let sanMarcoStopCoordinate = CLLocationCoordinate2D(latitude: 45.433187, longitude: 12.339925) // ,
let sottoPorticoStopCoordinate = CLLocationCoordinate2D(latitude: 45.436375, longitude: 12.337825) // ,
let callePerdonStopCoordinate = CLLocationCoordinate2D(latitude: 45.437535, longitude: 12.331559) // ,
let sanTomàStopCoordinate = CLLocationCoordinate2D(latitude: 45.435524, longitude: 12.328308) // ,
let sanSamueleStopCoordinate = CLLocationCoordinate2D(latitude: 45.433198, longitude: 12.327043) // ,
let sanMarcoVallaressoStopCoordinate = CLLocationCoordinate2D(latitude: 45.432329, longitude: 12.337181) // ,
let santaSofiaStopCoordinate = CLLocationCoordinate2D(latitude: 45.440509, longitude: 12.334584) // ,
let bacinoOrseoloStopCoordinate = CLLocationCoordinate2D(latitude: 45.434242, longitude: 12.336802) // ,
let sanZaccariaStopCoordinate = CLLocationCoordinate2D(latitude: 45.433695, longitude: 12.342482) // ,


let coordinatesArray = [accademiaStopCoordinate,santaBarnabaStopCoordinate,santaMariaDelGiglioStopCoordinate,BauerStopCoordinate,puntaDellaDoganaStopCoordinate,sanMarcoStopCoordinate,sottoPorticoStopCoordinate,callePerdonStopCoordinate,sanTomàStopCoordinate,sanSamueleStopCoordinate,sanMarcoVallaressoStopCoordinate,santaSofiaStopCoordinate,bacinoOrseoloStopCoordinate,sanZaccariaStopCoordinate]
let titleArray = ["Accademia","S.Barnaba","S.Maria Del Giglio","Bauer","Punta Della Dogana","S.Marco","Sottoportico","Calle Perdon","S.Tomà","S.Samuele","S.Marco Valleresso","S.Sofia","Bacino Orseolo","S.Zaccaria"]
let subtitleArray = ["I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest","I am the greatest"]






class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var VeniceMap: MKMapView!
    
    
    let locationManager = CLLocationManager()
    
    
    
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VeniceMap.delegate = self
        checkLocationServices()
        mapView()
        mapView(VeniceMap, didSelect: VeniceMap.dequeueReusableAnnotationView(withIdentifier: identifier)!)
        
    }
    
    
    
    
    
  // Center the user location when application initially runs
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            VeniceMap.setRegion(region, animated: true)
        }
        
    }
    
    // Creates the annotations on the map
    let identifier = "annotationId"
    
    func mapView(){
        var annotion : gondolaStations
        let gondolaStopAnnotation = VeniceMap.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        gondolaStopAnnotation?.animatesWhenAdded = true
        gondolaStopAnnotation?.titleVisibility = .adaptive
        VeniceMap.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: identifier)
        VeniceMap.dequeueReusableAnnotationView(withIdentifier: identifier)?.canShowCallout = false //important to recognize tap
        for ann in 0..<coordinatesArray.count{
                annotion = gondolaStations(coordinate: coordinatesArray[ann], title: titleArray[ann], subtitle: subtitleArray[ann])
                VeniceMap.addAnnotation(annotion)
        }
    }
    
  
    // Recognize when user taps on annotation + adds bottom sheet
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? gondolaStations {
            print("Your annotation title: \(annotation.title!)")
            // Show bottom sheet view
            bottomSheet.stationNameLabel.text = annotation.title
            showBottomSheetView(annotation: annotation)
            
        }
    }
    
    let bottomSheet = bottomSheetView()
    
    func showBottomSheetView(annotation: gondolaStations){
        
        bottomSheet.bottomSheetLauncher()
        //szMakeMovable()
        
    }
    
    
    // Checks the type of authorization given and acts based on that
    func checkAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            VeniceMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert to tell how to activate location
            break
        case .notDetermined:
            //locationManager.requestLocation()
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show alert
            break
        case .authorizedAlways :
            VeniceMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        default:
            print("not given authorization")
        }
        
        
    }
    
    
    //
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    // Checks if the device can use location, sets up the location manager and checks wether the authorization is given
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkAuthorization()
        } else {}
    }
    
    
    
    
    


}



extension ViewController: CLLocationManagerDelegate{
    
    
      // Center user location while moving (only when users asks for directuons)
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
//        VeniceMap.setRegion(region, animated: true)
//    }
    
    
    // In case the location authorizaion change
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
    
    
}



