//
//  SignUpViewController.swift
//  Auth
//
//  Created by Sidarth V on 17/04/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var SignUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0
        // Do any additional setup after loading the view.
        SignUp.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    
    func validateFields() -> String? {
        if FirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill all fields"
        }
        /*let cleanedPassword = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false{
            return "Password length 8, 1 Special Character and 1 Alpha"
        }*/
        return nil
    }
    
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            ErrorLabel.text = error!
            ErrorLabel.alpha = 1
        }
        else {
            let firstName = FirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = Email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["FirstName": firstName, "LastName": lastName, "uid": result!.user.uid]) { (error) in
                    if error != nil {
                        self.ErrorLabel.text = error!.localizedDescription
                        self.ErrorLabel.alpha = 1
                    }
                }
                let homeViewController = self.storyboard?.instantiateViewController(identifier: constants.storyboard.HomeViewController) as?HomeViewController
                homeViewController?.NameField.text = firstName + lastName
                homeViewController?.EmailField.text = email
                homeViewController?.userIdField.text = result?.user.uid
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    func transitionToHome() {
       
        
    }
}
