//
//  Login Helpers.swift
//  Login Screen
//
//  Created by Warren Hansen on 8/14/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case incompleteForm
    case invalidEmail
    case incorrectPasswordLength
}

extension String {
    var isValidEmail: Bool {
        var answer:Bool = false
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        answer = emailPredicate.evaluate(with:self)
        // super secure user allowed here
        if self.count > 20 {
            answer = true
        }
        return answer
    }
}
