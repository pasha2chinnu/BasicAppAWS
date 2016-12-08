//
//  SignInViewController.swift
//  TurtleLeaps
//
//  Created by kvanadev5 on 08/12/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var usernameView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var dontHaveAccountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 4
        
        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.white.cgColor
        
        usernameView.layer.borderWidth = 1
        usernameView.layer.cornerRadius = 3
        usernameView.layer.borderColor = UIColor.lightGray.cgColor
        
        passwordView.layer.borderWidth = 1
        passwordView.layer.cornerRadius = 3
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
        
        dontHaveAccountLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        checkValidations()
    }
    
    @IBAction func forgotPasswordButtonClicked(_ sender: Any) {
    }

    
    @IBAction func signUpButtonClicked(_ sender: Any) {
         self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "SignUpViewController") as UIViewController, animated: true)
    }
    
    func checkValidations(){
        let validCredentials = isValidCredentials(username:emailTextField.text!, password:passwordTextField.text!)
        let validEmail = isValidEmail(email: emailTextField.text!)
        if validCredentials && validEmail{
//            signInUser()
        }
    }
   
    
    /* textfield delegates*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

}
