//
//  HomeViewController.swift
//  Auth
//
//  Created by Sidarth V on 17/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var userIdField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        EmailField.text = "Email"
        NameField.text = "Name"
        userIdField.text = "UID"
    }
    

}
