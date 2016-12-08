//
//  SignUpViewController.swift
//  Opi9
//
//  Created by kvanadev5 on 27/10/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit
import AWSS3
import AWSCore
import Photos

class SignUpViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @IBOutlet var usernameView: UIView!
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var phonenumberTextfield: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var maleRadioButton: UIButton!
    @IBOutlet weak var femaleRadioButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userDescriptionView: UITextView!
    
    let checkedImage = UIImage(named: "selectedButton")! as UIImage
    let uncheckedImage = UIImage(named: "unselected")! as UIImage
    var gender:String?
    var registerType:String?
    let picker = UIImagePickerController()
    var pickImage = Bool()
    var selectedImageUrl: NSURL!
    var s3URL: NSURL!
    
    // Bool property
    var isCheckedWithMale: Bool = false {
        didSet{
           updateMaleButtonImage()
        }
    }
    
    var isCheckedWithFemale: Bool = false {
        didSet{
            updateFemaleButtonImage()
        }
    }
    
    //update Button Image
    func updateMaleButtonImage(){
        if isCheckedWithMale == true {
            maleRadioButton.setImage(checkedImage, for: .normal)
            femaleRadioButton.setImage(uncheckedImage, for: .normal)
            isCheckedWithFemale = false
            gender = maleLabel.text!
            checkImageWithGender()
        } else {
            maleRadioButton.setImage(uncheckedImage, for: .normal)
        }
    }
    
    //update Button Image
    func updateFemaleButtonImage(){
        if isCheckedWithFemale == true {
            femaleRadioButton.setImage(checkedImage, for: .normal)
            maleRadioButton.setImage(uncheckedImage, for: .normal)
            isCheckedWithMale = false
            gender = femaleLabel.text!
            checkImageWithGender()
        } else {
            femaleRadioButton.setImage(uncheckedImage, for: .normal)
        }
    }
    
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
    
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.tintColor = UIColor .white
        navigationController?.navigationBar.barTintColor = UIColor (colorLiteralRed: 154/255, green: 205/255, blue: 50/255, alpha: 0)
}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func maleRadioButtonClicked(_ sender: UIButton) {
            isCheckedWithMale = !isCheckedWithMale
    }

    @IBAction func femaleRadioButtonClicked(_ sender: UIButton) {
        isCheckedWithFemale = !isCheckedWithFemale
    }
 
    @IBAction func signUpClicked(_ sender: Any) {
        TurtleLeapsProgressHud.show(self.view)
        checkValidations()
    }
    
    
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
         selectedImageUrl = info[UIImagePickerControllerReferenceURL] as! NSURL
        TurtleLeapsProgressHud.show(self.view)
        profileImage.image=selectedImage
        pickImage = true
        self.dismiss(animated: true, completion: nil)
        uploadProfileImageToAWS()
    }
    
    func checkImageWithGender()
    {
        if pickImage {
            uploadProfileImageToAWS()
        }else{
        if gender == "Male"{
            self.profileImage.image = UIImage(named: "male")
        }else{
            self.profileImage.image = UIImage(named: "female")
        }
        }
    }
    
    func checkValidations(){
        let checkUserFields = isUserFieldsAreValid(firstname:firstnameTextfield.text!,lastname:lastnameTextfield.text!)
        let isValid =  isValidEmail(email: emailTextfield.text!)
        let checkPasswordFields = isPasswordAreValid(password:passwordTextfield.text!,confirmPassword:confirmPasswordTextfield.text!)
        let checkPhoneNumber = isPhoneNumberValid(phonenumber:phonenumberTextfield.text!)
        if checkUserFields && isValid && checkPasswordFields && checkPhoneNumber{
//        checkUsernameValidation(firstname:firstnameTextfield.text!)
           self.signupUser()
            }else{
                TurtleLeapsProgressHud.hide(self.view)
            }
        }
    
    func signupUser() {
        
        let params = [ "firstname":firstnameTextfield.text!,
                       "lastname": lastnameTextfield.text!,
                       "email": emailTextfield.text!,
                       "password": passwordTextfield.text!,
                       "password_confirmation":confirmPasswordTextfield.text,
                       "phone": phonenumberTextfield.text!,
                       "gender": gender] as [String : Any]                                                               //registerType
        /*
        NetworkInterface.fetchJSON(.signup, headers: nil, payload: params, requestCompletionHander: {(success, data, response,error) in
            if success == true, let data = data{
                                
            }
            DispatchQueue.main.async {
                Opi9ProgressHud.hide(self.view)
                 self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "SignInViewController") as UIViewController, animated: true)
            }
        })
        */
    }
    
    ///// aws imageUpload ////////
    func uploadProfileImageToAWS(){
        var localFileName:String?
        
        if let imageToUploadUrl = selectedImageUrl
        {
            var phResult = PHAsset.fetchAssets(withALAssetURLs: [imageToUploadUrl as URL], options: nil)
            localFileName = phResult.firstObject?.value(forKey: "filename") as! String?
        }
        if localFileName == nil
        {
            return
        }
        // Configure AWS Cognito Credentials
        let credentialsProvider:AWSCognitoCredentialsProvider = AWSCognitoCredentialsProvider(regionType:AWSRegionType.usWest2, identityPoolId: kOpi9IdentityPoolId)
        let configuration = AWSServiceConfiguration(region:AWSRegionType.usEast1, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // Set up AWS Transfer Manager Request
        let remoteName = localFileName
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.body = generateImageUrl(fileName:remoteName!)
        uploadRequest?.key = remoteName
        uploadRequest?.bucket = kS3BucketName
        uploadRequest?.contentType = "image/jpeg"
        
        let transferManager = AWSS3TransferManager.default()
        // Perform file upload
        transferManager?.upload(uploadRequest).continue({ (task:AWSTask) -> Any? in
            
            if let error = task.error {
                print("Upload failed with error: (\(error.localizedDescription))")
            }
            
            if let exception = task.exception {
                print("Upload failed with exception (\(exception))")
            }
            
            if task.result != nil {
                
                self.s3URL = URL(string: "https://s3.amazonaws.com/\(kS3BucketName)/\(uploadRequest!.key!)")! as NSURL!
                print("Uploaded to:\n\(self.s3URL)")
                DispatchQueue.main.async {
                    TurtleLeapsProgressHud.hide(self.view)
                }
                // Read uploaded image and display in a view
                let imageData = NSData(contentsOf: self.s3URL as URL)
                if let downloadedImageData = imageData
                {
                    DispatchQueue.main.async {
                        
                    }
                }
            }
            else {
                print("Unexpected empty result.")
                TurtleLeapsProgressHud.hide(self.view)
            }
            return nil
        })
        
    }
    func generateImageUrl(fileName: String) -> URL
    {
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))
        let data: NSData = UIImagePNGRepresentation(profileImage.image!)! as NSData
        data.write(to: path as URL, atomically: true)
        return path as URL
    }

    func navigateUserToHomeView(){
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as UIViewController, animated: true)
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "username is already taken", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
 
}
