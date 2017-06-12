//
//  newPost.swift
//  Duding
//
//  Created by parsataleb on 6/11/17.
//  Copyright © 2017 parsataleb. All rights reserved.
//

import Foundation
import Eureka
import CoreLocation
import UIKit
import Firebase

typealias Emoji = String
let 👦🏼 = "👦🏼", 🍐 = "🍐", 💁🏻 = "💁🏻", 🐗 = "🐗", 🐼 = "🐼", 🐻 = "🐻", 🐖 = "🐖", 🐡 = "🐡"



class newPost:FormViewController {
    
    
    let ref = Database.database().reference(withPath: "studyGroups/activePosts")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .orange }
        LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orange  }
        CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orange }
        DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }
        
        form +++
            
            Section()
            
            <<< TextRow("titleTag") {
                $0.title = "Title"
                $0.placeholder = "Set A Title for the Post"
            }
            
            <<< DateRow() { $0.value = Date(); $0.title = "Event Date" }
            
            
            <<< SwitchRow("publicTag") {
                $0.title = "Public"
                $0.value = true
            }
            
            
            <<< StepperRow() {
                $0.title = "Available Spots"
                $0.value = 1.0
        }
        
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            let section = form.last!
        //
        //            section <<< PopoverSelectorRow<Emoji>() {
        //                $0.title = "PopoverSelectorRow"
        //                $0.options = [💁🏻, 🍐, 👦🏼, 🐗, 🐼, 🐻]
        //                $0.value = 💁🏻
        //                $0.selectorTitle = "Choose an Emoji!"
        //            }
        //        }
        

            <<< LocationRow(){
                $0.title = "Meeting Place"
                $0.value = CLLocation(latitude: 37.872488, longitude: -122.260841)
            }
            
            <<< ImageRow(){
                $0.title = "Post Background"
            }
            
            
            <<< MultipleSelectorRow<Emoji>() {
                $0.title = "Attendies"
                $0.options = [💁🏻, 👦🏼]
                $0.value = ["creator"]
                }
                .onPresent { from, to in
                    to.sectionKeyForValue = { option in
                        switch option {
                        case 💁🏻: return "Facebook Friends"
                        case 👦🏼: return "Users"
                        case "creator": return "myself"
                        default: return ""
                        }
                    }
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(newPost.multipleSelectorDone(_:)))
        }
        
        
    }
    
    
    @IBAction func newItemDoneTapped(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Confirmation",
                                      message: "Please confirm your new post.",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
                                        // 1
                                        //                                        guard let textField = alert.textFields?.first,
                                        //                                            let text = textField.text else { return }
                                        
                                        
                                        let row: TextRow? = self.form.rowBy(tag: "titleTag")
                                        let titleValue = row?.value
                                        
                                        
                                        // 2
                                        let groceryItem = GroceryItem(creatorNameField: "unknown", titleField: titleValue!, locationNameField: "unknown", rankField: "unknown", timeField: "unknown", deadlineField: "unknown", priceField: "unknown", eventDateField: "unknown", approvedRequestsCountField: "unknown", creatorID: "unknown", attendiesField: "unknown", shortDescriptionField: "unknown", creatorIDField: "unknown", startTimeField: "unknown", endTimeField: "unknown", addressField: "unknown", availableSpots: "unknown", longDescriptionField: "unknown", availableSpotsField: "unknown")
                                        
                                        
                                        // 3
                                        let groceryItemRef = self.ref.child("IDK")
                                        
                                        // 4
                                        groceryItemRef.setValue(groceryItem.toAnyObject())
                                        
                                        //self.performSegue(withIdentifier: "mySegueID", sender: nil)

                                        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

