//
//  Constants.swift
//  Opi9
//
//  Created by kvanadev5 on 16/11/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import Foundation

/*
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb:Int) {
        self.init(red:(rgb >> 16) & 0xff, green:(rgb >> 8) & 0xff, blue:rgb & 0xff)
    }
}
*/

let kOpi9IdentityPoolId = ""
let kS3BucketName = ""




func isValidEmail(email:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

func isUserFieldsAreValid(firstname:String,lastname:String) -> Bool{
    if firstname.isEmpty || lastname.isEmpty  {
        return false
    }else{
        return true
    }
}
    


    func isPasswordAreValid(password:String,confirmPassword:String) -> Bool{
        if password.isEmpty || confirmPassword.isEmpty  {
            return false
        }else{
            if password == confirmPassword {
                return true
            }else{
                return false
            }
        }
    }

    func isPhoneNumberValid(phonenumber:String) -> Bool{
        if phonenumber.isEmpty {
            return false
        }else{
            return true
        }
    }

    func isCheckedWithOthersValues(gender:String) -> Bool{
        if gender.isEmpty {
            return false
        }else{
            return true
        }
    }

    func isValidCredentials(username:String, password:String) ->Bool{
        if username.isEmpty || password.isEmpty {
            return false
        }else{
            return true
        }
    }

    /*
    func errorAlert(error:NSError,self:UIViewController){
        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    */


