//
//  GoogleMapsGeocodeResponseModel.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 31/05/24.
//

import Foundation

struct GoogleMapsGeocodeResponseModel: Codable {
    let results: [GeocodeResultModel]?
    let status: String?
}
