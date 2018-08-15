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

// add progress bar
// add error at top of ui
// completion handler for login then auth manually
// delegates to show progress bar or error
// annimation to show text fields
// handle horizontal


import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let textFieldParser = TextFieldParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        textFieldParser.checkInputAndLogin(signUp: true, user: User(email:  emailTextField.text!, password: passwordTextField.text!))
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        textFieldParser.checkInputAndLogin(signUp: false, user: User(email:  emailTextField.text!, password: passwordTextField.text!))
    }
}
