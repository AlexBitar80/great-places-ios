//
//  LocationService.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 26/05/24.
//

import Foundation

enum LocationError: Error {
    case invalidURL
    case invalidApiKey
}

class LocationService {
    static let shared = LocationService()
    
    func generateLocationPreviewImage(latitude: Double, longitude: Double) throws -> String {
        guard let apiKey = Environments.googleMapsAPIKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw LocationError.invalidApiKey
        }
        
        let urlString = """
        https://maps.googleapis.com/maps/api/staticmap?center=\(latitude),\(longitude)&zoom=17&size=350x200&maptype=roadmap&markers=color:red%7Clabel:A%7C\(latitude),\(longitude)&key=\(apiKey)
        """
        
        guard let url = URL(string: urlString) else {
            throw LocationError.invalidURL
        }
        
        return url.absoluteString
    }
}
