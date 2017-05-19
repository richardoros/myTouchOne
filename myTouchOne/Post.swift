//
//  Post.swift
//  myTouchOne
//
//  Created by Richard Oros on 28/04/2017.
//  Copyright © 2017 Richard Oros. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _postRef: Firebase!
    
    private var _postKey: String!
    private var _postText: String!
    private var _postVotes: Int!
    private var _username: String!
    
    var jokeKey: String {
        return _postKey
    }
    
    var jokeText: String {
        return _postText
    }
    
    var jokeVotes: Int {
        return _postVotes
    }
    
    var username: String {
        return _username
    }
    
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = key
        
        // Within the Post, or Key, the following properties are children
        
        if let votes = dictionary["votes"] as? Int {
            self._postVotes = votes
        }
        
        if let post = dictionary["postText"] as? String {
            self._postText = post
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        } else {
            self._username = ""
        }
        
        // The above properties are assigned to their key.
        
        self._postRef = DataService.dataService.POST_REF.childByAppendingPath(self._postKey)
    }
}
