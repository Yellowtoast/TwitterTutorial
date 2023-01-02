//
//  User.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2023/01/02.
//

import Foundation

struct User{
    let uid: String
    let fullname: String
    let email: String
    let username: String
    let profileImageUrl: URL?

    
    init(uid: String, dictionary: [String: AnyObject]){
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = URL(string: dictionary["profileImageUrl"] as? String ?? "")
            
        
    }
}
