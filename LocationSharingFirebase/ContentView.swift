//
//  ContentView.swift
//  LocationSharingFirebase
//
//  Created by 1 on 24/09/21.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

struct ContentView: View {
    
    @State var name = ""
    @ObservedObject var observer = MapViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Enter Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if name != "" {
                    NavigationLink {
                        MapView(name: self.name, geopoints: self.observer.data as! [String : GeoPoint])
                            .navigationBarTitle("", displayMode: .inline)
                    } label: {
                        Text("Share Location")
                    } //: NAV LINK

                } //: IF CASE
                
            } //: VSTACK
            .padding()
            .navigationBarTitle("Location Sharing")
        } //: NAVIGATION
       
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




