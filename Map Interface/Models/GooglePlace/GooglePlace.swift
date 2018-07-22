//
//  GooglePlace.swift
//  chefspot
//
//  Created by Roberto Guzman on 7/13/18.
//  Copyright © 2018 Fortytwo Sports. All rights reserved.
//

import Foundation
import CoreLocation

struct GooglePlace: Codable {
    
    //basic info
    var geometry: PlaceGeometry?
    var icon: String?
    var id: String?
    var name: String?
    var photos: [PlacePhoto]?
    var placeId: String?
    var reference: String?
    var types: [String]?
    var vicinity: String?
    var priceLevel: Double?
    var rating: Double?
    
    //details
    var formattedAddress: String?
    var formattedPhoneNumber: String?
    var website: String?
    var reviews: [PlaceReview]?
    
    //custom
    var photoData: Data?
    var isFavorite: Bool?
}
