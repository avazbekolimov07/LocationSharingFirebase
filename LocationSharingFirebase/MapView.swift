//
//  MapView.swift
//  LocationSharingFirebase
//
//  Created by 1 on 24/09/21.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

struct MapView: UIViewRepresentable {
    
    var name = ""
    var geopoints : [String : GeoPoint]
    
    let map = MKMapView()
    let manager = CLLocationManager()
    
    func makeCoordinator() -> MapView.Coordinator {
        return MapView.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        
        manager.delegate = context.coordinator // context here is argument
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        let centre = CLLocationCoordinate2D(latitude: +40.730610, longitude: -73.935242)
        let region = MKCoordinateRegion(center: centre, span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
        map.region = region
        manager.requestWhenInUseAuthorization()
        
        
        return map
    } //: FUNC
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        for i in geopoints {
            
            if i.key != name {
                
            let point = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: i.value.latitude, longitude: i.value.longitude)
    
            point.title = i.key
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(point)
            }
        }
    } //: FUNC
    
    class Coordinator : NSObject, CLLocationManagerDelegate {
        
        var parent : MapView
        
        init(parent1 : MapView) {
            parent = parent1
        }
    
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied {
                print("denied")
            }
            if status == .authorizedWhenInUse {
                print("autherinUse")
            }
        } //: FUNC
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let last = locations.last
            
            let db = Firestore.firestore()
            
            db.collection("locations").document("sharing").setData(
                ["updates" : [self.parent.name : GeoPoint(
                    latitude: (last?.coordinate.latitude)!,
                    longitude: (last?.coordinate.longitude)!
                )] // dictionary 'key' is - name of user and 'value' is - geoPoint of user.
                ] , merge: true
            ) { (error) in //setData end
                
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                print("sucess")
            }
        } //: FUNC
    } //: CLASS
} //: STRUCT
