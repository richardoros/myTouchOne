//
//  PostFeedTableViewController.swift
//  myTouchOne
//
//  Created by Richard Oros on 28/04/2017.
//  Copyright © 2017 Richard Oros. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class PostFeedTableViewController: UIViewController {
    
    var jokes = [Joke]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observeEventType is called whenever anything changes in the Firebase - new Jokes or Votes.
        // It's also called here in viewDidLoad().
        // It's always listening.
        
        DataService.dataService.JOKE_REF.observeEventType(.Value, withBlock: { snapshot in
            
            // The snapshot is a current look at our jokes data.
            
            print(snapshot.value)
            
            self.jokes = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let joke = Joke(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        
                        self.jokes.insert(joke, atIndex: 0)
                    }
                }
                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
        })
    }
    
    
    
    
    
    
    
}
