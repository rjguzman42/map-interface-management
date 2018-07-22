//
//  GMSMapView+Extension.swift
//  chefspot
//
//  Created by Roberto Guzman on 7/10/18.
//  Copyright © 2018 Fortytwo Sports. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    func getRadius() -> CLLocationDistance {
        
        let centerCoordinate = getCenterCoordinate()
        // init center location from center coordinate
        let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        let topCenterCoordinate = self.getTopCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        let radius = CLLocationDistance(centerLocation.distance(from: topCenterLocation))
        
        return round(radius)
    }
    
    func getCenterCoordinate() -> CLLocationCoordinate2D {
        let centerPoint = center
        let centerCoordinate = projection.coordinate(for: centerPoint)
        return centerCoordinate
    }
    
    func getTopCenterCoordinate() -> CLLocationCoordinate2D {
        // to get coordinate from CGPoint of your map
        let topCenterCoor = convert(CGPoint(x: frame.size.width / 2.0, y: 0), from: self)
        let point = projection.coordinate(for: topCenterCoor)
        return point
    }
}
