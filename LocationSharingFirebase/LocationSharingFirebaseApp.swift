//
//  LocationSharingFirebaseApp.swift
//  LocationSharingFirebase
//
//  Created by 1 on 24/09/21.
//

import SwiftUI
import Firebase
import CoreLocation
import MapKit

@main
struct LocationSharingFirebaseApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
