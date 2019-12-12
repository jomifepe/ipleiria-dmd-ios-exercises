//
//  Meal.swift
//  FoodTracker
//
//  Created by José Pereira on 11/8/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding, Codable {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    var photoURL: URL?
    var restaurant: Restaurant?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let photoURL = "photoURL"
        static let restaurant = "restaurant"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int, photoURL: URL? = nil, restaurant: Restaurant? = nil) {
        // Should fail if there’s no name or if the rating is negative.
        
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.photoURL = photoURL
        self.restaurant = restaurant
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(rating, forKey: PropertyKey.rating)
        coder.encode(photoURL, forKey: PropertyKey.photoURL)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = coder.decodeInteger(forKey: PropertyKey.rating)
        let photoURL = coder.decodeObject(forKey: PropertyKey.photoURL) as? URL
        let restaurant = coder.decodeObject(forKey: PropertyKey.restaurant) as? Restaurant
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, photoURL: photoURL, restaurant: restaurant)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case photoURL = "photo"
        case rating
        case restaurant
    }
}
