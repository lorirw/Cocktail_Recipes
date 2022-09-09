//
//  ViewController.swift
//  Cocktail_Recipes
//
//  Created by Laura Rodak on 08092022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tabelView: UITableView!
    
    var cocktails = Cocktails()
    var myCocktails: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tabelView.dataSource = self
        tabelView.delegate = self
        
        cocktails.getData {
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }
        
    }
    
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("myCocktails").appendingPathExtension("json")
        
        guard let data =  try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            myCocktails = try jsonDecoder.decode(Dictionary.self, from: data)
            tabelView.reloadData()
        } catch {
            print("ERROR loading data \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("myCocktails").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(myCocktails)
        do {
            try? data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("ERROR saving data \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let destination = segue.destination as! DetailsViewController
            let selectedIndexPath = tabelView.indexPathForSelectedRow!
            destination.coctail = cocktails.cocktailArray[selectedIndexPath.row]
            destination.myCocktails = myCocktails
        }
    }
    
    @IBAction func unwindFromDetails(for segue: UIStoryboardSegue) {
        let source = segue.source as! DetailsViewController
        myCocktails = source.myCocktails
        tabelView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.cocktailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == cocktails.cocktailArray.count-1 && cocktails.alphabetIndex < cocktails.alphabet.count {
            cocktails.getData {
                DispatchQueue.main.async {
                    self.tabelView.reloadData()
                }
            }
       }
        cell.textLabel?.text = cocktails.cocktailArray[indexPath.row].strDrink
        let cocktailName = cocktails.cocktailArray[indexPath.row].strDrink
        if let cocktailRating = myCocktails[cocktailName] {
            cell.detailTextLabel?.text = cocktailRating
        } else {
            cell.detailTextLabel?.text = "-"
        }
        return cell
    }
    
}

