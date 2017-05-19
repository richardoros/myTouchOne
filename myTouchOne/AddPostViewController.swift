//
//  AddPostViewController.swift
//  myTouchOne
//
//  Created by Richard Oros on 28/04/2017.
//  Copyright © 2017 Richard Oros. All rights reserved.
//

import Foundation
import Firebase


class AddPostViewController: UIViewController {

    var currentUsername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get username of the current user, and set it to currentUsername, so we can add it to the Post.
        
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            
            let currentUser = snapshot.value.objectForKey("username") as! String
            
            print("Username: \(currentUser)")
            self.currentUsername = currentUser
        }, withCancelBlock: { error in
            print(error.description)
        })
    }
    
    
//    @IBAction func savePost(sender: AnyObject) {
//        
//        let postText = postField.text
//        
//        if postText != "" {
//            
//            // Build the new Post.
//            // AnyObject is needed because of the votes of type Int.
//            
//            let newPost: Dictionary<String, AnyObject> = [
//                "postText": postText!,
//                "votes": 0,
//                "author": currentUsername
//            ]
//            
//            // Send it over to DataService to seal the deal.
//            
//            DataService.dataService.createNewPost(joke: newPost)
//            
//            if let navController = self.navigationController {
//                navController.popViewController(animated: true)
//            }
//        }
//    }
    
    
    
    
    
    
    
}
