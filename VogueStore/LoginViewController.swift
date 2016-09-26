//
//  LoginViewController.swift
//  VogueStore
//
//  Created by Corey McCourt on 9/23/16.
//  Copyright © 2016 Corey McCourt. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions
    @IBAction func login(_ sender: AnyObject) {
        authenticateUser()
    }
    
    // MARK: - Utility Functions
    func authenticateUser() {
        let context: LAContext = LAContext()
        var error: NSError?
        let localizedReason = "Authentication is required"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason, reply: { (success: Bool, error: Error?) in
                if success {
                    OperationQueue.main.addOperation({ 
                        self.performSegue(withIdentifier: "login", sender: self)
                    })
                }
                else {
                    print(error?.localizedDescription)
                    let code = (error as! NSError).code
                    
                    switch code {
                    case LAError.systemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        break
                        
                    case LAError.userCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        break
                        
                    case LAError.userFallback.rawValue:
                        print("User selected to enter custom password")
                        OperationQueue.main.addOperation({ () -> Void in
                            self.showPasswordAlert()
                        })
                        break
                        
                    default:
                        print("Authentication failed")
                        OperationQueue.main.addOperation({ () -> Void in
                            self.showPasswordAlert()
                        })
                        break;
                        
                    }
                    
                }
            })
        }
    }
    
    func showPasswordAlert() {
        print("Password Alert")
    }
}
