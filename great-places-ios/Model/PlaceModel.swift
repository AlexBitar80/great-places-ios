//
//  Place.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 17/05/24.
//

import Foundation

struct Place {
    let id: String
    let title: String
    let location: PlaceLocation
    let image: String
    
    init(id: String, title: String, location: PlaceLocation, image: String) {
        self.id = id
        self.title = title
        self.location = location
        self.image = image
    }
    
    static var places = [
        Place(id: "1", title: "Copacabana Beach", location: PlaceLocation(latitude: -22.9719, longitude: -43.1823, address: "Avenida Atlântica, Copacabana, 22070-001, Rio de Janeiro, RJ"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "2", title: "Ipanema Beach", location: PlaceLocation(latitude: -22.9850, longitude: -43.2021, address: "Rua Visconde de Pirajá, Ipanema, 22410-003, Rio de Janeiro, RJ"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "3", title: "Christ the Redeemer", location: PlaceLocation(latitude: -22.9519, longitude: -43.2106, address: "Parque Nacional da Tijuca, Alto da Boa Vista, 22241-330, Rio de Janeiro, RJ"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "4", title: "Sugarloaf Mountain", location: PlaceLocation(latitude: -22.9519, longitude: -43.1658, address: "Avenida Pasteur, Urca, 22290-240, Rio de Janeiro, RJ"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "5", title: "Iguaçu Falls", location: PlaceLocation(latitude: -25.6866, longitude: -54.4446, address: "Rodovia das Cataratas, Foz do Iguaçu, 85855-750, PR"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "6", title: "Amazon Rainforest", location: PlaceLocation(latitude: -3.4653, longitude: -62.2159, address: "Floresta Amazônica, Amazonas"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "7", title: "Lençóis Maranhenses", location: PlaceLocation(latitude: -2.3838, longitude: -42.8335, address: "Parque Nacional dos Lençóis Maranhenses, Barreirinhas, 65590-000, Maranhão"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "8", title: "Pantanal", location: PlaceLocation(latitude: -18.5949, longitude: -56.8746, address: "Pantanal Matogrossense, 78390-000, Mato Grosso"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "9", title: "Chapada Diamantina", location: PlaceLocation(latitude: -12.5719, longitude: -41.5304, address: "Parque Nacional da Chapada Diamantina, Palmeiras, 46930-000, Bahia"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "10", title: "Fernando de Noronha", location: PlaceLocation(latitude: -3.8441, longitude: -32.4233, address: "Arquipélago de Fernando de Noronha, 53990-000, Pernambuco"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "11", title: "Bonito", location: PlaceLocation(latitude: -21.1269, longitude: -56.4839, address: "Centro, Bonito, 79290-000, Mato Grosso do Sul"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
        Place(id: "12", title: "Paraty", location: PlaceLocation(latitude: -23.2207, longitude: -44.7131, address: "Centro Histórico, Paraty, 23970-000, Rio de Janeiro, RJ"), image: "https://images.unsplash.com/photo-1496412705862-e0088f16f791"),
    ]
}

