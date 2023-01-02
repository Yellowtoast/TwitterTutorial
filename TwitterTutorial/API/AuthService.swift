//
//  AuthService.swift
//  TwitterTutorial
//
//  Created by 강지혜 on 2023/01/02.
//
import UIKit
import Firebase

struct AuthCredentials{
    let email: String
    let password: String
    let fullName: String
    let username: String
    let profileImage: UIImage
}

struct AuthService{
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredentials){
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData) { (meta, error) in
            
            storageRef.downloadURL(completion: { (url, error) in
                guard let  profileImageUrl = url?.absoluteString else {
                    print("DEBUG: 프로필 URL 에러 => \(error?.localizedDescription)")
                    return
                }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password){ (result, error) in
                    if let error = error{
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else {
                        print("DEBUG: 유저 uid => \(result?.user.uid)")
                        
                        return }
                    
                    let values = ["email": credentials.email, "username": credentials.username, "fullname": credentials.fullName, "profileImageUrl": profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values){
                        (error, ref) in
                        print("DEBUG: 유저정보 업데이트 성공")
                    }
                    
                }
            })
            
            
            
            
            
        }
    }
}
