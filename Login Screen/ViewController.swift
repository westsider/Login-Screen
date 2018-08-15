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
// delegates to show progress bar or error
// annimation to show text fields
// handle horizontal
// pan background

// possible endpoints Nasa Data https://api.nasa.gov/api.html#authentication


import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordHeightConstraing: NSLayoutConstraint!
    
    @IBOutlet weak var mainStackViewHeight: NSLayoutConstraint!
    
    let textFieldParser = TextFieldParser()
    
    var showFieldsState:Bool = true
    
    var start:CGFloat = 300
    var finish:CGFloat = 330
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailHeightConstraint.constant = 0
        passwordHeightConstraing.constant = 0
        mainStackViewHeight.constant = start
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        textFieldParser.checkInputAndLogin(signUp: true, user: User(email:  emailTextField.text!, password: passwordTextField.text!))
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        textFieldParser.checkInputAndLogin(signUp: false, user: User(email:  emailTextField.text!, password: passwordTextField.text!))
    }
    
    @IBAction func expandTextfieldAction(_ sender: UIButton) {
        showAndHideTextFields(now: showFieldsState)
        if showFieldsState { showFieldsState = false } else { showFieldsState = true }
    }
    
    func showAndHideTextFields(now:Bool) {
        
        if now {
            emailHeightConstraint.constant = 30
            passwordHeightConstraing.constant = 30
            mainStackViewHeight.constant = finish
        } else {
            emailHeightConstraint.constant = 0
            passwordHeightConstraing.constant = 0
            mainStackViewHeight.constant = start
        }
        
        UIView.animate(
            withDuration: 0.6,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.01,
            options: [],
            animations: {
                self.view.layoutIfNeeded()
        })
    }
    
}
