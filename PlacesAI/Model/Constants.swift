//
//  Constants.swift
//  PlacesAI
//
//  Created by User on 24/04/24.
//

import Foundation

struct Constants {
    static let apiKey = "AIzaSyCsMYZQFsDXjV7X8WYjZ9-NYEda7eovMqQ"
    static let prompt = """
    give me inspiration for activities that can be done during the day in the city of Malang. Provide the response as an array of JSON as 
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
