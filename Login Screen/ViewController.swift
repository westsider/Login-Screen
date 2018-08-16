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
//      view
//      label
//      progress bar
//      gesture recog
// add error at top of ui
// delegates to show progress bar or error
// pan background

// possible endpoints Nasa Data https://api.nasa.gov/api.html#authentication


import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordHeightConstraing: NSLayoutConstraint!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var logInLabel: UILabel!
    
    let textFieldParser = TextFieldParser()
    
    var showFieldsState:Bool = true
    
    var start:CGFloat = 330
    var finish:CGFloat = 330
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailHeightConstraint.constant = 0
        passwordHeightConstraing.constant = 0
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        textFieldParser.checkInputAndLogin(signUp: true, user: User(email:  emailTextField.text!, password: passwordTextField.text!))
    }
    
    @IBAction func logInViewTapped(_ sender: UITapGestureRecognizer) {
        startNetworkCallAnnimation()
        textFieldParser.checkInputAndLogin(signUp: false, user: User(email:  emailTextField.text!, password: passwordTextField.text!))
    }
    
    //MARK: - Handle login progress bar
    func startNetworkCallAnnimation() {
        
        logInLabel.text = "Signing In..."
        view.layoutIfNeeded()
        setProgress(percent: 0.7)
        
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            animations: {
                self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                //self.finishNetworkCall()
            }
        }
    }
    
    func finishNetworkCall() {
        
        logInLabel.text = "Connected"
        setProgress(percent: 1.0)
        
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
    
    func setProgress(percent:Float) {
        progressBar.isHidden = false
        progressBar.progress = percent
    }

    
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
