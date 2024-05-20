//
//  PlaceLocationModel.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 18/05/24.
//

import Foundation

struct PlaceLocation {
    let latitude: Double
    let longitude: Double
    let address: String?
    
    init(latitude: Double, longitude: Double, address: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
}
