//
//  CategorySingleton.swift
//  FetchRewardsChallenege1
//
//  Created by wenwu howard on 11/26/21.
//

import Foundation
import UIKit

class CategorySingleton {
    
    
    static let shared = CategorySingleton()
    
    
    private var categoryID:  String
    private var categoryName:  String
    private var categoryDesc:  String
    
    
    
    
    
    private init() {
        categoryID = ""
        categoryName = ""
        categoryDesc = ""
    }
    
    
    
    
    func setCatID(theID: String) {
        categoryID = theID
    }
    
    func getCategoryID() -> String {
        return categoryID
    }
    
    
    func setCatName(theName: String) {
        categoryName = theName
    }
    
    func getCategoryName() -> String {
        return categoryName
    }
    
    
    
    func setCatDesc(theDesc: String) {
        categoryDesc = theDesc
    }
    
    func getCategoryDesc() -> String {
        return categoryDesc
    }
    
    
    
    
    
}
