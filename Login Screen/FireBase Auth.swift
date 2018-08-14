//
//  FireBase Auth.swift
//  Login Screen
//
//  Created by Warren Hansen on 8/14/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthSystem {
    
    func createNewUser(email:String, passWord:String) {
        
        // https://firebase.google.com/docs/auth/ios/email-link-auth
        // https://code.tutsplus.com/tutorials/get-started-with-firebase-authentication-for-ios--cms-29227
        
        Auth.auth().createUser(withEmail: email, password: passWord) { (user, error) in
            
            if (user != nil) {
                print("\nWe created a user!\n")
                debugPrint(user?.description)
            } else {
                print(error?.localizedDescription as Any)
            }
            
        }
        
    }
    
    func authExistingUser(email:String, passWord:String) {
        
        Auth.auth().signIn(withEmail: email, password: passWord) { (user, error) in
            if (user != nil) {
                print("\nWe logged in a user!\n")
                debugPrint(user?.description)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
}
