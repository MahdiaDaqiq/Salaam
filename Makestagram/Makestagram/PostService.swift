//
//  PostService.swift
//  Salaam
//
//  Created by basira daqiq on 7/11/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import Firebase


struct PostService {
       /* i commente becouse i had 2 of them 
    static func create(for texts: UITextView) {
            //_>
            let currentUser = User.current
        let post = Post(texts: texts.text, textHeight: 50)
        
            // 1
            let rootRef = Database.database().reference()
            let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
            let newPostKey = newPostRef.key
            
            // 2
            UserService.followers(for: currentUser) { (followerUIDs) in
                // 3
                let timelinePostDict = ["poster_uid" : currentUser.uid]
                
                // 4
                var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
                
                // 5
                for uid in followerUIDs {
                    updatedData["timeline/\(uid)/\(newPostKey)"] = timelinePostDict
                }
                
                // 6
                let postDict = post.dictValue
                updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
                
                // 7
                rootRef.updateChildValues(updatedData)
            }
            // _>
        }
    // foolow and timeline working. something with view l
        
    
    
    */
    
   
    static func showLike(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("posts").child(posterUID).child(postKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            
            LikeService.isPostLiked(post) { (isLiked) in
                post.isLiked = isLiked
                completion(post)
            }
        })
    }
 

    
    static func show(posterUID: String, completion: @escaping ([Post]?) -> Void) {
        
        //THIS IS THE ONE THAT WAS CALLED WHEN SEAN WAS HELPING WOOT
        
        let ref = Database.database().reference().child("posts").child(posterUID)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            var postArray = [Post]()
            
            if let posts = snapshot.children.allObjects as? [DataSnapshot] {
                for post in posts {
                    
                    let myPost = Post(snapshot: post)
                    print("Current post:")
                    print("Text data: \(String(describing: myPost?.textData))")
                    
                    postArray.append(myPost!)
                }
            }
            
            completion(postArray)
            
        })
    }
    
    static func create(text: String, height: Int) {
        // 1
        let currentUser = User.current
        // 
        let post = Post(texts: text, textHeight: CGFloat(height))
        // 3
        //let dict = post.dictValue
        
        let rootRef = Database.database().reference()
        let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
        let newPostKey = newPostRef.key
        
        // 2
        UserService.followers(for: currentUser) { (followerUIDs) in
            // 3
            let timelinePostDict = ["poster_uid" : currentUser.uid]
            
            // 4
            var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
            
            // 5
            for uid in followerUIDs {
                updatedData["timeline/\(uid)/\(newPostKey)"] = timelinePostDict
            }
            
            // 6
            let postDict = post.dictValue
            updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
            
            // 7
            rootRef.updateChildValues(updatedData)
        }
       
    }
 
    // flag 1
    
    static func flag(_ post: Post) {
        // 1
        guard let postKey = post.key else { return }
        
        // 2
        let flaggedPostRef = Database.database().reference().child("flaggedPosts").child(postKey)
        
        // 3
        let flaggedDict = ["text": post.textData,
                           "poster_uid": post.poster.uid,
                           "reporter_uid": User.current.uid]
        
        // 4
        flaggedPostRef.updateChildValues(flaggedDict)
        
        // 5
        let flagCountRef = flaggedPostRef.child("flag_count")
        flagCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
            let currentCount = mutableData.value as? Int ?? 0
            
            mutableData.value = currentCount + 1
            
            return TransactionResult.success(withValue: mutableData)
        })
    }
 
}

    




























