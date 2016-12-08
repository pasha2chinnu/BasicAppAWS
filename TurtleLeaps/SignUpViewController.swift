//
//  SignUpViewController.swift
//  TurtleLeaps
//
//  Created by kvanadev5 on 08/12/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var firstnameTextfield: UITextField!
    @IBOutlet var lastnameTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var confirmPasswordTextfield: UITextField!
    @IBOutlet var phonenumberTextfield: UITextField!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var maleLabel: UILabel!
    @IBOutlet var femaleLabel: UILabel!
    @IBOutlet var maleRadioButton: UIButton!
    @IBOutlet var femaleRadioButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
    }
}
