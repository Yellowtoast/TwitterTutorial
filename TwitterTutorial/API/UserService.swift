//
//  UserService.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2023/01/02.
//

import UIKit
import Firebase


struct UserService{
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User.init(uid: uid, dictionary: dictionary)
            
            completion(user)
        }
    }
}
