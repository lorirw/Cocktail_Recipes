//
//  Cocktails.swift
//  CocktailRecipes
//
//  Created by Laura Rodak on 06092022.
//

import Foundation

class Cocktails {
    
    struct ReturnedCocktails: Codable {
        var drinks: [Cocktail]
    }
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var alphabetIndex = 0
    
    let urlBase = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
    var urlString = ""
    var cocktailArray: [Cocktail] = []
    var isFetching = false

    func getData(completed: @escaping ()->()) {
        guard !isFetching else {
            print("Dind't call getData \(urlString)")
            completed()
            return
        }
        isFetching = true
        
        urlString = urlBase + alphabet[alphabetIndex]
        alphabetIndex += 1
        
        guard let url = URL(string: urlString) else {
            print("ERROR: could not create URL")
            isFetching = false
            completed()
            return
        
    }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERROR \(error.localizedDescription)")
            }
            do  {
                let returned = try JSONDecoder().decode(ReturnedCocktails.self, from: data!)
                self.cocktailArray = self.cocktailArray + returned.drinks
            } catch {
                print("ERROR \(error.localizedDescription)")
            }
            self.isFetching = false
            completed()
        }
    
      task.resume()
   }
}

