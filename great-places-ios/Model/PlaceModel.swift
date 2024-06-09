//
//  Place.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 17/05/24.
//

import Foundation

struct Place {
    var id = UUID()
    let title: String
    let location: PlaceLocation
    let image: Data
    
    init(id: UUID, title: String, location: PlaceLocation, image: Data) {
        self.id = id
        self.title = title
        self.location = location
        self.image = image
    }
}
