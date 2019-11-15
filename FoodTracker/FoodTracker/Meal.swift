//
//  Meal.swift
//  FoodTracker
//
//  Created by José Pereira on 11/8/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import UIKit

class Meal {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        // Should fail if there’s no name or if the rating is negative.
        
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
