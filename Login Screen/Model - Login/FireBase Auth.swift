//
//  FireBase Auth.swift
//  Login Screen
//
//  Created by Warren Hansen on 8/14/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol ChangeBttnTxtDelegate: class {
    func changeRegisterBttnTxt(message:String)
    func changeLoginBttnTxt(message:String)
    func showFirebaseError(message:String)
}

class FirebaseAuthSystem {
    
    weak var delegate: ChangeBttnTxtDelegate?
    
    func createNewUser(email:String, passWord:String) {
        
        // https://firebase.google.com/docs/auth/ios/email-link-auth
        // https://code.tutsplus.com/tutorials/get-started-with-firebase-authentication-for-ios--cms-29227
        
        Auth.auth().createUser(withEmail: email, password: passWord) { (user, error) in
            
            if (user != nil) {
                self.delegate?.changeRegisterBttnTxt(message: "\(email) created.")
                if let user:String = user?.description {
                    debugPrint(user)
                }
                
            } else {
                if let error:String = error?.localizedDescription {
                    self.delegate?.showFirebaseError(message: "Warning: \(error)")
                }
            }
        }
    }
    
    func authExistingUser(email:String, passWord:String) {
        
        Auth.auth().signIn(withEmail: email, password: passWord) { (user, error) in
            if (user != nil) {
                self.delegate?.changeLoginBttnTxt(message: "\(email), logged in.")
                if let user:String = user?.description {
                    debugPrint(user)
                }
            } else {
                if let error:String = error?.localizedDescription {
                    self.delegate?.showFirebaseError(message: "Warning: \(error)")
                }
            }
        }
    }
}
