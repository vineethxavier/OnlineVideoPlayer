
//  ViewController.swift
//  Project_Final
//
//  Created by Varun Yadav on 10/26/17.
//  Copyright © 2017 Vineeth Xavier. All rights reserved.
//

import UIKit
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
  var dataToSend  = ""
   
     let signInButton = GIDSignInButton(frame: CGRect(x: 0,y: 0,width: 100,height: 50))
 
    @IBOutlet weak var ConButton: UIButton!
    @IBAction func ContinueButton(_ sender: Any) {

       
        self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        signInButton.center = view.center
        view.addSubview(signInButton)
          ConButton.alpha = 0
            NameLabel.alpha = 0
        WelcomeLabel.alpha = 0
}
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            
            print("\(error.localizedDescription)")
            
            // [START_EXCLUDE silent]
            
            NotificationCenter.default.post(
                
            name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            
            // [END_EXCLUDE]
        } else{
            
            NameLabel.text = user.profile.name
            
//            print(user.profile.name)
            
            dataToSend.append(user.profile.name)
            
            toggleAuthUI()
        }
    }

    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            signInButton.isHidden = true
            UIView.animate(withDuration: 1, animations: {
              self.WelcomeLabel.alpha = 1
            }) { (true) in
                self.name2label()
            }
        } else {
            signInButton.isHidden = false
        }
    }
    
    func  name2label(){
        UIView.animate(withDuration: 0.6, animations: {
            self.NameLabel.alpha = 1
        }
        ){ (true) in
            self.sign2Button()
            
        }}
    
    func sign2Button(){
        UIView.animate(withDuration: 0.5, animations: {
            self.ConButton.alpha = 1
        }
        )}
    
    }

    // Edited by vineeth


