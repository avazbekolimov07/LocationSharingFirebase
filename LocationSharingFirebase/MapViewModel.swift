//
//  MapViewModel.swift
//  LocationSharingFirebase
//
//  Created by 1 on 24/09/21.
//

import SwiftUI
import Firebase
import CoreLocation
import MapKit



class MapViewModel: ObservableObject {
    @Published var data = [String : Any]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("locations").document("sharing").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            let updates = snapshot?.get("updates") as! [String : GeoPoint]
            
            self.data = updates
            
        } // addSNAPSHOT
        
    } //: init
} //: CLASS
