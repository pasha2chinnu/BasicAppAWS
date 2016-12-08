//
//  SignUpViewController.swift
//  TurtleLeaps
//
//  Created by kvanadev5 on 08/12/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

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
    @IBOutlet var usernameView: UIView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameView.layer.borderWidth = 0.5
        usernameView.layer.cornerRadius = 2
        usernameView.layer.borderColor = UIColor.black.cgColor
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2;
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.clipsToBounds = true;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.selectProfileImage))
        profileImage.addGestureRecognizer(tap)
        profileImage.isUserInteractionEnabled = true
        
        phonenumberTextfield.layer.cornerRadius = 3
        phonenumberTextfield.layer.borderWidth = 0.5
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width:10, height: 10))
        phonenumberTextfield.leftView = paddingView;
        phonenumberTextfield.leftViewMode = UITextFieldViewMode.always
        
        signupButton.layer.cornerRadius = 3
        genderLabel.adjustsFontSizeToFitWidth = true

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.tintColor = UIColor .white
        navigationController?.navigationBar.barTintColor = UIColor (colorLiteralRed: 154/255, green: 205/255, blue: 50/255, alpha: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ImagePicker Controller and picker delegate*/
    func selectProfileImage(){
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            picker.sourceType = UIImagePickerControllerSourceType.camera;
            picker.allowsEditing = false
        }else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        var selectedImage = UIImage()
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == "public.image"{
            selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        let fileurl : NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//        selectedImageUrl = info[UIImagePickerControllerReferenceURL] as! NSURL
//        TurtleLeapsProgressHud.show(self.view)
//        profileImage.image=selectedImage
//        pickImage = true
//        self.dismiss(animated: true, completion: nil)
//        uploadProfileImageToAWS()
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
    }
}
