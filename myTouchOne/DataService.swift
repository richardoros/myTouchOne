//
//  DataService.swift
//  myTouchOne
//
//  Created by Richard Oros on 28/04/2017.
//  Copyright © 2017 Richard Oros. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _JOKE_REF = Firebase(url: "\(BASE_URL)/posts")
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    
    func createNewPost(joke: Dictionary<String, AnyObject>) {
        
        // Save the Post
        // Post_REF is the parent of the new Posts: "posts".
        // childByAutoId() saves the joke and gives it its own ID.
        
        let firebaseNewPost = Post_REF.childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewPost.setValue(post)
    }
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    var JOKE_REF: Firebase {
        return _JOKE_REF
    }
}
