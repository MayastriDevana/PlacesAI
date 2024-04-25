//
//  PlaceRow.swift
//  PlacesAI
//
//  Created by User on 24/04/24.
//

import SwiftUI

struct PlaceRow: View {
    var place: Place
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(place.activity)
                .font(.system(.title2, design: .rounded))
            HStack{
                Group{
                    Image(systemName: "pin")
                    Text(place.place)
                }
                .font(.subheadline)
                Spacer()
                
                HStack{
                    Circle()
                        .fill(.green)
                        .frame(width: 20, height: 20)
                    Text("Rp\(place.price)")
                        .font(.subheadline)
                }
                .padding([.vertical, .horizontal], 8)
                .background(Color(.systemGroupedBackground))
                .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    PlaceRow(place: Place.dummyData[0])
}
