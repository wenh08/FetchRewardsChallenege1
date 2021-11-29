//
//  MealSingleton.swift
//  FetchRewardsChallenege1
//
//  Created by wenwu howard on 11/26/21.
//


import Foundation
import UIKit

class MealSingleton {
    
    
    static let shared = MealSingleton()
        
        
        private var mealID:  String
        private var mealName:  String
         
    
    
    
     
    private init() {
        mealID = ""
        mealName = ""
      
    }
    
    
    
    
    func setMealID(theID: String) {
        mealID = theID
    }
    
    func getMealID() -> String {
        return mealID
    }
    
    
    func setMealName(theName: String) {
        mealName = theName
    }
    
    func getMealName() -> String {
        return mealName
    }
 
}



