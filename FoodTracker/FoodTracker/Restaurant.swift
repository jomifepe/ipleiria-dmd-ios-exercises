//
//  Restaurant.swift
//  FoodTracker
//
//  Created by José Pereira on 12/6/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import Foundation
import MapKit
import os.log

class Restaurant: NSObject, NSCoding, Codable {
    var name: String
    var type: String?
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init?(name: String, type: String?, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.name = name
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
    }
    
    struct PropertyKey {
        static let name = "name"
        static let type = "type"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name , forKey: PropertyKey.name )
        coder.encode(type , forKey: PropertyKey.type )
        coder.encode(latitude , forKey: PropertyKey.latitude )
        coder.encode(longitude, forKey: PropertyKey.longitude )
    }
    
    required convenience init?(coder: NSCoder) {
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Restaurant object.", log:
                OSLog.default, type: .debug)
            return nil
        }
        
        let type = coder.decodeObject(forKey: PropertyKey.type) as? String
        
        let latitude = coder.decodeDouble(forKey: PropertyKey.latitude)
        
        let longitude = coder.decodeDouble(forKey: PropertyKey.longitude)
        self.init(name: name, type: type, latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case latitude = "lat"
        case longitude = "lon"
    }
}

class RestaurantMKAnnotation: NSObject, MKAnnotation {
    let title: String?
    let type: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, type: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.type = type
        self.coordinate = coordinate
        super.init()
    }
    
    convenience init(restaurant: Restaurant) {
        self.init(title: restaurant.name, type: (restaurant.type ?? "Undefined"),
                  coordinate: CLLocationCoordinate2D(latitude: restaurant.latitude, longitude:
                    restaurant.longitude))
    }
    
    var subtitle: String? {
        return "\(type) restaurant."
    }
}
