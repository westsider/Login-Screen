//
//  ViewController.swift
//  Login Screen
//
//  Created by Warren Hansen on 8/14/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//
/*  Required in app delegate
    import IQKeyboardManagerSwift
    IQKeyboardManager.shared.enable = true  */

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var firebaseAuthSystem = FirebaseAuthSystem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        checkUserInput(signUp: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        checkUserInput(signUp: false)
    }
    
    func checkUserInput(signUp:Bool) {
        
        do {
            try loginOr(signUp: signUp)
        } catch LoginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please FIll out both email and password.")
        } catch LoginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "Please make sure you format your email correctly")
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at leat 6 characters.")
        } catch {
            Alert.showBasic(title: "Unable To Login", message: "There was an error attempting to login")
        }
    }
    
    func loginOr(signUp:Bool) throws {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
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
            firebaseAuthSystem.createNewUser(email: email, passWord: password)
        } else {
            firebaseAuthSystem.authExistingUser(email: email, passWord: password)
        }
    }
    

}
