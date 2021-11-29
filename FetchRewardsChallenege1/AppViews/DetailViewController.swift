//
//  DetailViewController.swift
//  FetchRewardsChallenege1
//
//  Created by wenwu howard on 11/26/21.
//


import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var mealInstructions: UILabel!
    
    @IBOutlet weak var mealIngredient1: UILabel!
    
    @IBOutlet weak var mealIngredient2: UILabel!
    
    @IBOutlet weak var mealIngredient3: UILabel!
    
    @IBOutlet weak var mealIngredient4: UILabel!
    @IBOutlet weak var mealIngredient5: UILabel!
    @IBOutlet weak var mealIngredient6: UILabel!
    
    @IBOutlet weak var mealIngredient7: UILabel!
    
    @IBOutlet weak var mealIngredient8: UILabel!
    
    @IBOutlet weak var mealIngredient9: UILabel!
    
    @IBOutlet weak var mealMeasure1: UILabel!
    
    @IBOutlet weak var mealMeasure2: UILabel!
    @IBOutlet weak var mealMeasure3: UILabel!
    @IBOutlet weak var mealMeasure4: UILabel!
    
    @IBOutlet weak var mealMeasure5: UILabel!
    
    @IBOutlet weak var mealMeasure6: UILabel!
    @IBOutlet weak var mealMeasure7: UILabel!
    
    @IBOutlet weak var mealMeasure8: UILabel!
    @IBOutlet weak var mealMeasure9: UILabel!
    
    @IBOutlet weak var mealImage: UIImageView!
    
    @IBOutlet weak var mealName: UILabel!
    
    var mealID: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sharedDetail =  DetailSingleton.shared
        mealID =  sharedDetail.getMealID()
        
        print("MEAL ID BEING RECEIVED: \(mealID)")
        
        fetchDetails()
        
    }
    func fetchDetails(){
        
        let apiString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        
        let session = URLSession.shared
        let url = URL(string: apiString)!
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("JSON Error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                
                
                
                let deatilData = json?["meals"]
                for eachData in deatilData as! [Dictionary<String, AnyObject>] {
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        self.mealName.text = eachData["strMeal"] as! String ?? ""
                        
                        self.mealInstructions.text = eachData["strInstructions"] as! String ?? ""
                        
                        self.mealIngredient1.text = eachData["strIngredient1"] as! String ?? ""
                        self.mealIngredient2.text = eachData["strIngredient2"] as! String ?? ""
                        self.mealIngredient3.text = eachData["strIngredient3"] as! String ?? ""
                        self.mealIngredient4.text = eachData["strIngredient4"]as! String ?? ""
                        self.mealIngredient5.text = eachData["strIngredient5"]as! String ?? ""
                        self.mealIngredient6.text = eachData["strIngredient6"]as! String ?? ""
                        self.mealIngredient7.text = eachData["strIngredient7"]as! String ?? ""
                        self.mealIngredient8.text = eachData["strIngredient8"]as! String ?? ""
                        self.mealIngredient9.text = eachData["strIngredient9"]as! String ?? ""
                        
                        self.mealMeasure1.text =  eachData["strMeasure1"]as! String ?? ""
                        self.mealMeasure2.text = eachData["strMeasure2"]as! String ?? ""
                        self.mealMeasure3.text = eachData["strMeasure3"]as! String ?? ""
                        self.mealMeasure4.text = eachData["strMeasure4"]as! String ?? ""
                        self.mealMeasure5.text = eachData["strMeasure5"]as! String ?? ""
                        self.mealMeasure6.text = eachData["strMeasure6"]as! String ?? ""
                        self.mealMeasure7.text = eachData["strMeasure7"]as! String ?? ""
                        self.mealMeasure8.text = eachData["strMeasure8"]as! String ?? ""
                        self.mealMeasure9.text = eachData["strMeasure9"]as! String ?? ""
                        
                        
                        
                        let imageUrl =  eachData["strMealThumb"]as! String ?? ""
                        
                        self.mealImage.loadImageUsingCacheFromUrlString(urlString: imageUrl )
                        self.mealImage.contentMode = .scaleAspectFit
                        
                        
                    }
                    
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    
}




