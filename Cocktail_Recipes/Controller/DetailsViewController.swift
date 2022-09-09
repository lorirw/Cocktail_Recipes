//
//  DetailsViewController.swift
//  CocktailRecipes
//
//  Created by Laura Rodak on 06092022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var cocktailLabel: UILabel!
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var ingridientsText: UITextView!
    @IBOutlet weak var recipeText: UITextView!
    
    var coctail: Cocktail!
    var myCocktails: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if coctail == nil {
            coctail = Cocktail()
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        cocktailLabel.text = coctail.strDrink
        alcoholLabel.text = "✅"
        if coctail.strAlcoholic != "Alcoholic" {
            alcoholLabel.text = "❌"
        }
        recipeText.text = coctail.strInstructions
        ingridientsText.text = ""
        creatingIngridientsList()
        ratingTextField.text = myCocktails[coctail.strDrink] ?? "-"
        
        guard let url = URL(string: coctail.strDrinkThumb ?? "") else {return}
        do {
            let data = try Data(contentsOf: url)
            self.cocktailImage.image = UIImage(data: data)
        } catch {
            print("ERROR: could not load image")
        }
    }
    
    func addIngridients(ingridient: String?, measure: String?) {
    guard measure != nil else {return}
    ingridientsText.text += measure!
    guard ingridient != nil else {return}
    ingridientsText.text +=  " \(ingridient!)\n"
    }
    
    func creatingIngridientsList() {
        ingridientsText.text = ""
        addIngridients(ingridient: coctail.strIngredient1, measure: coctail.strMeasure1)
        addIngridients(ingridient: coctail.strIngredient2, measure: coctail.strMeasure2)
        addIngridients(ingridient: coctail.strIngredient3, measure: coctail.strMeasure3)
        addIngridients(ingridient: coctail.strIngredient4, measure: coctail.strMeasure4)
        addIngridients(ingridient: coctail.strIngredient5, measure: coctail.strMeasure5)
        addIngridients(ingridient: coctail.strIngredient6, measure: coctail.strMeasure6)
        addIngridients(ingridient: coctail.strIngredient7, measure: coctail.strMeasure7)
        addIngridients(ingridient: coctail.strIngredient8, measure: coctail.strMeasure8)
        addIngridients(ingridient: coctail.strIngredient9, measure: coctail.strMeasure9)
        addIngridients(ingridient: coctail.strIngredient10, measure: coctail.strMeasure10)
        addIngridients(ingridient: coctail.strIngredient11, measure: coctail.strMeasure11)
        addIngridients(ingridient: coctail.strIngredient12, measure: coctail.strMeasure12)
        addIngridients(ingridient: coctail.strIngredient13, measure: coctail.strMeasure13)
        addIngridients(ingridient: coctail.strIngredient14, measure: coctail.strMeasure14)
        addIngridients(ingridient: coctail.strIngredient15, measure: coctail.strMeasure15)
        if ingridientsText.text != "" {
            ingridientsText.text.removeLast()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ratingNumber = Int(ratingTextField.text!) {
            if ratingNumber >= 1 && ratingNumber <= 10  {
                myCocktails[coctail.strDrink] = String(ratingNumber)
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    

}
