//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by José Pereira on 11/8/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    //MARK: Properties
     
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadSampleMeals()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        cell.labelView.text = meal.name
        cell.imgView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    //MARK: Private Methods
    private func loadSampleMeals() {
        let alheira = UIImage(named: "alheira")
        let chourica = UIImage(named: "chourica")
        let morcela = UIImage(named: "morcela")
        
        guard let meal1 = Meal(name: "Alheira", photo: alheira, rating: 4) else {
            fatalError("Unable to instantiate alheira")
        }
         
        guard let meal2 = Meal(name: "Chouriça", photo: chourica, rating: 5) else {
            fatalError("Unable to instantiate chourica")
        }
         
        guard let meal3 = Meal(name: "Morcela de arroz", photo: morcela, rating: 3) else {
            fatalError("Unable to instantiate morcela")
        }
        meals += [meal1, meal2, meal3]
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as?
            ViewController,
            let meal = sourceViewController.meal {
            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
