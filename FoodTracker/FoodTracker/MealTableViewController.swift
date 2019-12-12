//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by José Pereira on 11/8/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    static let MealsURL = "https://www.mocky.io/v2/5deaa7d9300000cc302b0a69"
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            // Load the sample data.
            loadSampleMeals()
        }
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
            addMeal(meal: meal)
        }
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        guard let url = URL(string: MealTableViewController.MealsURL) else {
            os_log("Invalid URL.", log: OSLog.default, type: .error)
            return
        }
        
        // download meals list from network
        URLSession(configuration: .default).dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    // parse json to [Meal]
                    let newMeals: [Meal] = try JSONDecoder().decode([Meal].self, from: data)
                    
                    for meal in newMeals {
                        if let photoURL = meal.photoURL {
                            
                            // download meal’s photo
                            URLSession(configuration: .default).dataTask(with: photoURL) {
                                (data, response, error) in
                                
                                if let error = error {
                                    print(error.localizedDescription)
                                } else if
                                    let data = data,
                                    let response = response as? HTTPURLResponse,
                                    response.statusCode == 200 {
                                    
                                    meal.photo = UIImage(data: data)
                                }
                                
                                // add downloaded meal with photo
                                DispatchQueue.main.async {
                                    self.addMeal(meal: meal)
                                }
                            }.resume()
                        } else {
                            // add downloaded meal without photo
                            DispatchQueue.main.async {
                                self.addMeal(meal: meal)
                            }
                        }
                    }
                } catch let parseError as NSError {
                    print(parseError.localizedDescription)
                }
            }
        }.resume()
    }
    
    private func saveMeals() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            try data.write(to: Meal.ArchiveURL)
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [Meal]? {
        do {
            let codedData = try Data(contentsOf: Meal.ArchiveURL)
            let meals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? [Meal]
            os_log("Meals successfully loaded.", log: OSLog.default, type: .debug)
            return meals;
        } catch {
            os_log("Failed to load meals...", log: OSLog.default, type: .error)
            return nil
        }
    }
    
    private func addMeal(meal: Meal) {
        let newIndexPath = IndexPath(row: self.meals.count, section: 0)
        meals.append(meal);
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
}
