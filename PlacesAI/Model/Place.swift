//
//  Place.swift
//  PlacesAI
//
//  Created by User on 24/04/24.
//

import Foundation

struct Place: Codable{
    var place: String
    var activity: String
    var price: String
}

extension Place{
    static let dummyData: [Place] = [
        Place(
            place: "Baso Damas",
            activity: "Eat meat ball",
            price: "35.000"
            
        )
    ]
}
