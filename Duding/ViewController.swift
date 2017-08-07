//
//  ViewController.swift
//  Duding
//
//  Created by parsataleb on 6/7/17.
//  Copyright © 2017 parsataleb. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import MapKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate, CLLocationManagerDelegate {

    var locManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookButtons()
        
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
    func mostraPosizione(){
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if (authorizationStatus == .authorizedWhenInUse) {
            locManager.startUpdatingLocation()
        } else {
            locManager.requestWhenInUseAuthorization()
            mostraPosizione()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //make sure the view is loaded first before adding subviews
        mostraPosizione()
    }
    fileprivate func setupFacebookButtons() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        

    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            
            print("Successfully logged in with our user: ", user ?? "")
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

