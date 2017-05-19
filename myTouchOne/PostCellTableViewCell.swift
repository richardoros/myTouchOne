//
//  PostCellTableViewCell.swift
//  myTouchOne
//
//  Created by Richard Oros on 28/04/2017.
//  Copyright © 2017 Richard Oros. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class PostCellTableViewCell: UITableViewCell {
    
    
    
    
    var joke: Post!
    var voteRef: Firebase!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically.
        
        let tap = UITapGestureRecognizer(target: self, action: "voteTapped:")
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }
    
    func voteTapped(sender: UITapGestureRecognizer) {
        
        // observeSingleEventOfType listens for a tap by the current user.
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
                
                // addSubtractVote(), in Post.swift, handles the vote.
                
                self.post.addSubtractVote(true)
                
                // setValue saves the vote as true for the current user.
                // voteRef is a reference to the user's "votes" path.
                
                self.voteRef.setValue(true)
            } else {
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
                self.post.addSubtractVote(false)
                self.voteRef.removeValue()
            }
            
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        // We are using a custom cell.
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTableViewCell") as? PostCellTableViewCell {
            
            // Send the single post to configureCell() in PostCellTableViewCell.
            
            cell.configureCell(post)
            
            return cell
            
        } else {
            
            return PostCellTableViewCell()
            
        }
    }
    
    
    // Add or Subtract a Vote from the Post.
    
    func addSubtractVote(addVote: Bool) {
        
        if addVote {
            _postVotes = _postVotes + 1
        } else {
            _postVotes = _postVotes - 1
        }
        
        // Save the new vote total.
        
        _postRef.childByAppendingPath("votes").setValue(_postVotes)
        
    }
    
    func configureCell(post: Post) {
        self.post = post
        
        // Set the labels and textView.
        
        self.postText.text = post.postText
        self.totalVotesLabel.text = "Total Votes: \(post.postVotes)"
        self.usernameLabel.text = post.username
        
        // Set "votes" as a child of the current user in Firebase and save the post's key in votes as a boolean.
        
        voteRef = DataService.dataService.CURRENT_USER_REF.childByAppendingPath("votes").childByAppendingPath(post.postKey)
        
        // observeSingleEventOfType() listens for the thumb to be tapped, by any user, on any device.
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            // Set the thumb image.
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                
                // Current user hasn't voted for the post... yet.
                
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
            } else {
                
                // Current user voted for the post!
                
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
            }
        })
    }
    
 
    
    
}
