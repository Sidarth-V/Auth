//
//  LogInEmailViewController.swift
//  Auth
//
//  Created by Sidarth V on 17/04/21.
//

import UIKit
import Firebase

class LogInEmailViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var LogIn: UIButton!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        error.alpha = 0
    }
    
    @IBAction func LogInTapped(_ sender: Any) {
        let Email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let Password = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: Email!, password: Password!) { (result, err) in
            if err != nil{
                self.error.text = err?.localizedDescription
                self.error.alpha = 1
            }
            else {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: constants.storyboard.HomeViewController) as?HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
