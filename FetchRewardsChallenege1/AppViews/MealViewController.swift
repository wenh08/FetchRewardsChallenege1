//
//  MealViewController.swift
//  FetchRewardsChallenege1
//
//  Created by wenwu howard on 11/26/21.
//

import UIKit

class MealViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    var categoryMealName: String = ""
    
    
    let myVertCellSize:  CGSize  = CGSize( width: 340, height: 272 )
    
    let myVertCVSpacing: CGFloat = CGFloat( 4.0 ) //vertical spacing for
    
    
    
    @IBOutlet weak var mealCollectionView: UICollectionView!
    
    
    
    
    var mealsArray: [Meals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sharedPref = CategorySingleton.shared
        
        categoryMealName = sharedPref.getCategoryName()
        
        print("MEAL NAME BEING RECEIVED: \(categoryMealName)")
        
        
        fetchMeals()
        
        
        
        
        
       
        mealCollectionView.dataSource = self
        mealCollectionView.delegate = self
        
        
    }
    private func fetchMeals() {
        
        let apiString: String  = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categoryMealName)"
        let session  = URLSession.shared
        let url = URL(string: apiString)!
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Json error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                
                var tempID: Meals
                
                self.mealsArray = []
                
                let mealData = json?["meals"]
                
                for eachData in mealData as! [Dictionary<String, AnyObject>] {
                    
                    
                    tempID = Meals.init()
                    tempID.mealID = eachData["idMeal"] as! String
                    tempID.mealName  = eachData["strMeal"] as? String ?? ""
                    tempID.mealImage = eachData["strMealThumb"] as? String ?? ""
                    
                    self.mealsArray.append( tempID )
                    
                    
                    self.mealsArray.sort {
                        $0.mealName.lowercased() < $1.mealName.lowercased()
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.mealCollectionView.reloadData()
                    }
                    
                    print("MEAL ARRAY: \(self.mealsArray)")
                    
                    
                    
                 
                }
                
                
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  mealsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        return myVertCellSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let mealCell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: "MyMealCell", for: indexPath) as! MealCollectionViewCell
     
        
        mealCell.mealImage.loadImageUsingCacheFromUrlString(urlString: mealsArray[indexPath.item].mealImage)
        mealCell.mealImage.contentMode = .scaleAspectFill
        
        mealCell.mealName.text = mealsArray[indexPath.item].mealName
        
        return mealCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let sharedPref = DetailSingleton.shared
        
    
        sharedPref.setMealID(theID: mealsArray[indexPath.item].mealID)
        
         print("MEAL ID BEING SET: \(mealsArray[indexPath.item].mealID)")
        
        sharedPref.setMealName(theName: mealsArray[indexPath.item].mealName)
        
       
        
        
       
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
  



}
 

 


extension MealViewController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return UIEdgeInsets(top: myVertCVSpacing, left: myVertCVSpacing, bottom: myVertCVSpacing, right: myVertCVSpacing)
    
}



func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
    return myVertCVSpacing
    
}

}
