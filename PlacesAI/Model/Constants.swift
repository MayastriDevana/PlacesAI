//
//  Constants.swift
//  PlacesAI
//
//  Created by User on 24/04/24.
//

import Foundation

struct Constants {
    static let apiKey = ""
    static let prompt = """
    give me inspiration for activities that can be done during the day in the city of Palembang. Provide the response as an array of JSON as
    {
        [
            "place": "name",
            "activity": "activities",
            "price": "5.000"
        ]
    }
    
    only. Remove any backticks.
    
    """
}
