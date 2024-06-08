//
//  LocationService.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 26/05/24.
//

import Foundation
import GoogleMaps

enum LocationError: Error {
    case invalidURL
    case invalidApiKey
    case invalidData
    case noResults
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

    func getAddressFrom(latitude: Double, longitude: Double) async throws -> String {
        
        guard let apiKey = Environments.googleMapsAPIKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw LocationError.invalidApiKey
        }
        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw LocationError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(GoogleMapsGeocodeResponseModel.self, from: data)
        
        return response.results?[0].formattedAddress ?? "Endereço não encontrado"
    }
}
