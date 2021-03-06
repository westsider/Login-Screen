//
//  TextField Parser.swift
//  Login Screen
//
//  Created by Warren Hansen on 8/14/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation

protocol ShowParseErrorDelegate: class {
    func errorFromParse(message:String)
}

class TextFieldParser {
    
    weak var parseDelagate: ShowParseErrorDelegate?
    
    func checkInputAndLogin(signUp:Bool, user: User, callback: @escaping (Bool) -> ()) {
        
        do {
            try loginOr(signUp: signUp, user: user)
            callback(true)
        } catch LoginError.incompleteForm {
            parseDelagate?.errorFromParse(message: "Please fIll out both email and password.")
            callback(false)
        } catch LoginError.invalidEmail {
            parseDelagate?.errorFromParse(message: "Please make sure you format your email correctly")
            callback(false)
        } catch LoginError.incorrectPasswordLength {
            parseDelagate?.errorFromParse(message: "Password should be at leat 6 characters.")
            callback(false)
        } catch {
            if let user = user.email {
                parseDelagate?.errorFromParse(message: "There was an error attempting to login \(user)")
                callback(false)
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
    }
}
