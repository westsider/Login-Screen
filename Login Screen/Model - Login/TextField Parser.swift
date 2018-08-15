//
//  TextField Parser.swift
//  Login Screen
//
//  Created by Warren Hansen on 8/14/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation

struct TextFieldParser {
    
    func checkInputAndLogin(signUp:Bool, user: User) {
        
        do {
            try loginOr(signUp: signUp, user: user)
        } catch LoginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please FIll out both email and password.")
        } catch LoginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "Please make sure you format your email correctly")
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at leat 6 characters.")
        } catch {
            if let user = user.email {
                Alert.showBasic(title: "Unable To Login", message: "There was an error attempting to login \(user)")
            }
        }
    }
    
    func loginOr(signUp:Bool, user: User) throws {
        
        guard let email = user.email else {
            return
        }
        guard let password = user.password else {
            return
        }
        
        if email.isEmpty || password.isEmpty {
            throw LoginError.invalidEmail
        }
        
        if !email.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        if password.count < 6 {
            throw LoginError.incorrectPasswordLength
        }
        
        if signUp {
            FirebaseAuthSystem().createNewUser(email: email, passWord: password)
        } else {
            FirebaseAuthSystem().authExistingUser(email: email, passWord: password)
        }
    }
}
