//
//  GeocodeResultModel.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 31/05/24.
//

import Foundation

struct GeocodeResultModel: Codable {
    let formattedAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
    }
}
