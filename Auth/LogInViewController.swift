//
//  ViewController.swift
//  Auth
//
//  Created by Sidarth V on 16/04/21.
//

import UIKit
import Firebase
import GoogleSignIn
import AuthenticationServices

class LogInViewController : UIViewController {

    
    @IBOutlet weak var AppleSignIn: ASAuthorizationAppleIDButton!
    @IBOutlet weak var SignButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SignButton.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        
        AppleSignIn.cornerRadius = 10
        AppleSignIn.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
    }
    @objc func ButtonTapped() {
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
     }
 }
    
extension LogInViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // return the current view window
        return self.view.window!
    }
}

extension LogInViewController : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("authorization error")
        guard let error = error as? ASAuthorizationError else {
            return
        }

        switch error.code {
        case .canceled:
            // user press "cancel" during the login prompt
            print("Canceled")
        case .unknown:
            // user didn't login their Apple ID on the device
            print("Unknown")
        case .invalidResponse:
            // invalid response received from the login
            print("Invalid Respone")
        case .notHandled:
            // authorization request not handled, maybe internet failure during login
            print("Not handled")
        case .failed:
            // authorization failed
            print("Failed")
        @unknown default:
            print("Default")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let credential = authorization.credential
        let appleIDCredential = credential as! ASAuthorizationAppleIDCredential
        let homeViewController = storyboard?.instantiateViewController(identifier: constants.storyboard.HomeViewController) as?HomeViewController
        homeViewController?.userIdField.text = appleIDCredential.user
        homeViewController?.NameField.text = appleIDCredential.fullName?.givenName
        homeViewController?.EmailField.text = appleIDCredential.email
    }
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: constants.storyboard.HomeViewController) as?HomeViewController
        homeViewController?.EmailField.text = "string"
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }

        
}
