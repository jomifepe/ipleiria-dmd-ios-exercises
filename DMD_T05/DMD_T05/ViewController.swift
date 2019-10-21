//
//  ViewController.swift
//  DMD_T05
//
//  Created by José Pereira on 10/18/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        let searchText = "chicken"
        
        startTracksDataTask(urlString: "https://api.edamam.com/search", queryString: "q=\(searchText)&app_id=caa4cc1d&app_key=e7729c5d2ef1fdf40af39a170f4f73b2&from=0&to=3&calories=591-722&health=alcohol-free")
        // startTracksDataTask(urlString: "https://itunes.apple.com/search", queryString: "media=music&entity=song&term=\(searchText)")
    }
    
    // MARK: data task
    
    func startTracksDataTask(urlString: String, queryString: String?) {
        
        let defaultSession = URLSession(configuration: .default)
        
        var tracks: [Track]?
        var dataTask: URLSessionTask?
        
        if var urlComponents = URLComponents(string: urlString)  {
            urlComponents.query = queryString
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) {
                (data, response, error) in // completion handler
                
                defer {
                    dataTask = nil
                }
                
                if let error = error {
                    print("DataTask error: " + error.localizedDescription)
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    tracks = self.parseJsonToTracks(data)
                    
                    DispatchQueue.main.async {
                        var resultString: String = ""
                        
                        if let results = tracks {
                            for result in results {
                                resultString += "\(result)\n"
                            }
                        }
                        
                        print(resultString)
                        self.label.text = resultString
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    // MARK: json parser
    
    private func parseJsonToTracks(_ data: Data) -> [Track]? {
        var response: [String: Any]?
        var tracks: [Track] = []
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)")
            return nil
        }
        
        guard let resultsArray = response!["results"] as? [Any] else {
            print("JSONSerialization error: Dictionary does not contain results key")
            return nil
        }
        
        var index = 0
        
        for trackDictionary in resultsArray {
            if
                let trackDictionary = trackDictionary as? [String: Any],
                let previewURLString = trackDictionary["previewUrl"] as? String,
                let previewURL = URL(string: previewURLString),
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String {
                
                let track = Track(name: name, artist: artist, previewURL: previewURL, index: index)
                tracks.append(track)
                index += 1
            } else {
                print("JSONSerialization error: Problem parsing trackDictionary")
            }
        }
        
        return tracks
    }
    
    private func parseJsonToRecipes(_ data: Data) -> [Recipe]? {
        var response: [String: Any]?
        var recipes: [Recipe] = []
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)")
            return nil
        }
        
        guard let hits = response!["hits"] as? [Any] else {
            print("JSONSerialization error: Dictionary does not contain hits key")
            return nil
        }
        
        var index = 0
        
//        for trackDictionary in resultsArray {
//            if
//                let trackDictionary = trackDictionary as? [String: Any],
//                let previewURLString = trackDictionary["previewUrl"] as? String,
//                let previewURL = URL(string: previewURLString),
//                let name = trackDictionary["trackName"] as? String,
//                let artist = trackDictionary["artistName"] as? String {
//
//                let track = Track(name: name, artist: artist, previewURL: previewURL, index: index)
//                tracks.append(track)
//                index += 1
//            } else {
//                print("JSONSerialization error: Problem parsing trackDictionary")
//            }
//        }
        
        for hit in hits {
            let recipe = hit["recipe"];
                let recipe = dictionary as? [String: Any],
                let label = recipe["label"] as? String,
                let previewURL = URL(string: previewURLString),
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String
        }
        
        return tracks
    }
}

// MARK: model
class Track {
    let artist: String
    let index: Int
    let name: String
    let previewURL: URL
    
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
}

extension Track: CustomStringConvertible {
    var description: String {
        return "\(index). \"\(name)\", by \(artist)"
    }
}

class Recipe {
//    "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_56008870a1e326be7851141fc49bd53e",
//    "label": "Roast Chicken",
//    "image": "https://www.edamam.com/web-img/c24/c24a86f98a8cc1f13f795bdba2dae614.jpg",
//    "source": "Epicurious",
//    "url": "http://www.epicurious.com/recipes/food/views/Roast-Chicken-394676",
//    "shareAs": "http://www.edamam.com/recipe/roast-chicken-56008870a1e326be7851141fc49bd53e/chicken/alcohol-free/591-722-cal",
//    "yield": 4.0,
//    "dietLabels": [
//    "Low-Carb"
//    ],
//    "healthLabels": [
//    "Sugar-Conscious",
//    "Peanut-Free",
//    "Tree-Nut-Free",
//    "Alcohol-Free"
//    ],
//    "cautions": [
//    ],
//    "ingredientLines": [
//    "1 tablespoon kosher salt",
//    "1 whole 4-pound chicken, giblets reserved for another use",
//    "1/4 cup (1/2 stick) unsalted butter, melted"
//    ],
    
    let source: String
    let label: String
    let image: String
    
    init(source: String, label: String, image: String) {
        self.source = source
        self.label = label
        self.image = image
    }
}

extension Recipe: CustomStringConvertible {
    var description: String {
        return "\(label) by \(source)"
    }
}
