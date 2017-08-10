//
//  CategoryViewController.swift
//  Duding
//
//  Created by parsataleb on 8/9/17.
//  Copyright © 2017 parsataleb. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabaseUI



class CategoryViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "study"
        {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! MainTableViewController
            
            
            targetController.sagee = "study"
        
            
        }
        else if segue.identifier == "athlete"
        {
            
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! MainTableViewController
            
            
            targetController.sagee = "athlete"
        }
        
        else if segue.identifier == "hang"
        {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! MainTableViewController
            
            
            targetController.sagee = "hang"
        }
        
        else if segue.identifier == "local"
        {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! MainTableViewController
            
            
            targetController.sagee = "local"
        }
        
        
        
    }
    
    
}


