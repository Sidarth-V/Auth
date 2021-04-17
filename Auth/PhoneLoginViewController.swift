//
//  PhoneLoginViewController.swift
//  Auth
//
//  Created by Sidarth V on 17/04/21.
//

import UIKit
import PhoneNumberKit
import Firebase

class PhoneLoginViewController: UIViewController {

    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var inputOtp: UITextField!
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputOtp.alpha = 0;
        Label.alpha = 0;
        // Do any additional setup after loading the view.
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withExamplePlaceholder = true
        phoneNumberTextField.withPrefix = true
        
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let phoneNumber = phoneNumberTextField.phoneNumber!.numberString.trimmingCharacters(in: .whitespacesAndNewlines)
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (result, error) in
            if error != nil{
                return
            }
            else {
                let verificationID = result
                self.button.setTitle("Submit", for: .normal)
                self.inputOtp.alpha = 1
                self.Label.alpha = 1
                self.phoneNumberTextField.alpha = 0
                let verificationCode = self.inputOtp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                print(verificationCode)
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)
                Auth.auth().signIn(with: credential) { (res, error) in
                    if error != nil {
                        return
                    }
                    else {
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: constants.storyboard.HomeViewController) as?HomeViewController
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            }
            
        }
    }
    
}
