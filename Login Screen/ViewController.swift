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


// add error at top of ui
// reset button on error
// pan background

// possible endpoints Nasa Data https://api.nasa.gov/api.html#authentication


import UIKit

class LoginViewController: UIViewController, ChangeBttnTxtDelegate, ShowParseErrorDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordHeightConstraing: NSLayoutConstraint!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var logInLabel: UILabel!
    
    @IBOutlet weak var progressBarRegister: UIProgressView!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    let textFieldParser = TextFieldParser()
    
    let firebaseAuthSystem = FirebaseAuthSystem()
    
    var showFieldsState:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailHeightConstraint.constant = 0
        passwordHeightConstraing.constant = 0
        textFieldParser.parseDelagate = self
        firebaseAuthSystem.delegate = self
    }
    
    func errorFromParse(message: String) {
        print("\n--------------\nmessage from protocol is \(message)\n--------------\n")
    }
    
    func changeRegisterBttnTxt(message: String) {
        print("\n--------------\nmessage from protocol is \(message)\n")
        finishButtonAnimation(login: false)
    }
    
    func changeLoginBttnTxt(message: String) {
        print("\n--------------\nmessage from protocol is \(message)\n")
        finishButtonAnimation(login: true)
    }
    
    func showFirebaseError(message: String) {
        print("\n--------------\nmessage from protocol is \(message)\n")
        //MARK: - Todo - Show error in UI
    }
    
    @IBAction func logInViewTapped(_ sender: UITapGestureRecognizer) {
        startButtonAnimation(logIn: true)
        let user = User(email:  emailTextField.text!, password: passwordTextField.text!)
        textFieldParser.checkInputAndLogin(signUp: false, user: user) { (finished) in
            if finished {
                print("Finished with input check")
                self.firebaseAuthSystem.authExistingUser(email: user.email!, passWord: user.password!)
            }
        }
    }
    
    @IBAction func registerViewTapped(_ sender: UITapGestureRecognizer) {
        startButtonAnimation(logIn: false)
        let user = User(email:  emailTextField.text!, password: passwordTextField.text!)
        textFieldParser.checkInputAndLogin(signUp: true, user: user) { (finished) in
            if finished {
                print("Finished with input check")
                self.firebaseAuthSystem.createNewUser(email: user.email!, passWord: user.password!)
            }
        }
    }
    
    
    //MARK: - Handle login progress bar
    func startButtonAnimation(logIn:Bool) {
        
        if logIn { logInLabel.text = "Signing In..." } else { registerLabel.text = "Sending Request.." }
        view.layoutIfNeeded()
        setProgress(percent: 0.7, logIn: logIn)
        
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            animations: {
                self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                //self.finishNetworkCall(login: logIn)
            }
        }
    }
    
    func finishButtonAnimation(login:Bool) {
        
        if login { logInLabel.text = "Logged In" } else { registerLabel.text = "Registered" }
        setProgress(percent: 1.0, logIn: login)
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0.0,
            usingSpringWithDamping: 5.5,
            initialSpringVelocity: 2.0,
            options: [],
            animations: {
                self.view.layoutIfNeeded()
        })
    }
    
    func setProgress(percent:Float, logIn:Bool) {
        if logIn {
            progressBar.isHidden = false
            progressBar.progress = percent
        } else {
            progressBarRegister.isHidden = false
            progressBarRegister.progress = percent
        }
        
    }

    //MARK: - Handle textfield animation
    @IBAction func expandTextfieldAction(_ sender: UIButton) {
        showAndHideTextFields(now: showFieldsState)
        if showFieldsState { showFieldsState = false } else { showFieldsState = true }
    }
    
    func showAndHideTextFields(now:Bool) {
        
        if now {
            emailHeightConstraint.constant = 30
            passwordHeightConstraing.constant = 30
        } else {
            emailHeightConstraint.constant = 0
            passwordHeightConstraing.constant = 0
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
