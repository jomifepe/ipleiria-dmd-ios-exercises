//
//  ViewController.swift
//  FoodTracker
//
//  Created by José Pereira on 10/11/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import UIKit
import OSLog
import MapKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: properties
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var tfMealName: UITextField!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tfMealName.delegate = self
        // imagePickerController.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            tfMealName.text = meal.name
            imageViewer.image = meal.photo
            ratingControl.rating = meal.rating
            
            tfMealName.isUserInteractionEnabled = false
            imageViewer.isUserInteractionEnabled = false
            ratingControl.isUserInteractionEnabled = false
            
            if let restaurant = meal.restaurant {
                let restaurantAnnotation = RestaurantMKAnnotation(restaurant: restaurant)
                mapView.addAnnotation(restaurantAnnotation)
                
                let regionRadius: CLLocationDistance = 200
                
                let coordinateRegion = MKCoordinateRegion(
                    center: restaurantAnnotation.coordinate,
                    latitudinalMeters: regionRadius,
                    longitudinalMeters: regionRadius)
                mapView.setRegion(coordinateRegion, animated: true)
            } else {
                mapView.isHidden = true
            }
        } else {
            mapView.isHidden = true
        }
    }
    
    
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //        lblMealName.text = textField.text
    //    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        tfMealName.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = tfMealName.text ?? ""
        let photo = imageViewer.image
        let rating = ratingControl.rating
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

