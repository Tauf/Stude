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
            

            
            
            <<< DateRow("eventDateTag") {
                
                $0.value = Date()
                $0.title = "Event Date"
            }
            
            
            <<< TimeRow("startTimeTag") {
                $0.title = "Start Time"
                $0.value = Date().addingTimeInterval(60*60*24)
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeInlineRow! = self?.form.rowBy(tag: "endTimeTag")
                    if row.value?.compare(endRow.value!) == .orderedDescending {
                        endRow.value = Date(timeInterval: 60*60*24, since: row.value!)
                        endRow.cell!.backgroundColor = .white
                        endRow.updateCell()
                    }
                }

            
            <<< TimeRow("endTimeTag"){
                $0.title = "End Time"
                $0.value = Date().addingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeInlineRow! = self?.form.rowBy(tag: "startTimeTag")
                    if row.value?.compare(startRow.value!) == .orderedAscending {
                        row.cell!.backgroundColor = .red
                    }
                    else{
                        row.cell!.backgroundColor = .white
                    }
                    row.updateCell()
                }

            
            
            <<< SwitchRow("publicTag") {
                $0.title = "Public?"
                $0.value = true
            }
            
            
            <<< StepperRow("availableSpotsTag") {
                $0.title = "Available Spots"
                $0.value = 1
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
            
            <<< TextRow("shortDescriptionTag") {
                $0.title = "Event Summary"
                $0.placeholder = "Short Description"
            }
            
            <<< TextAreaRow("longDescriptionTag") {
                $0.placeholder = "Details"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 110)
            }
            
            <<< MultipleSelectorRow<Emoji>() {
                $0.title = "Attendees"
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
        
        
        //        let alert = UIAlertController(title: "Confirmation",
        //                                      message: "Please confirm your new post.",
        //                                      preferredStyle: .alert)
        //
        //        let saveAction = UIAlertAction(title: "Save",
        //                                       style: .default) { _ in
        // 1
        //                                        guard let textField = alert.textFields?.first,
        //                                            let text = textField.text else { return }
        
        
        var row: TextRow?
        
        row = self.form.rowBy(tag: "titleTag")
        let titleValue = row?.value
        
        row = self.form.rowBy(tag: "shortDescriptionTag")
        let shortDescriptionValue = row?.value
        var row2: StepperRow?
        
        row2 = self.form.rowBy(tag: "availableSpotsTag")
        
        let availableSpotsValue = row2?.value
        
        var row3: DateRow?
        
        row3 = self.form.rowBy(tag: "eventDateTag")
        let eventDateValue = row3?.value

        var row4: TimeRow?
        
        row4 = self.form.rowBy(tag: "startTimeTag")
        let startTimeValue = row4?.value

        row4 = self.form.rowBy(tag: "endTimeTag")
        let endTimeValue = row4?.value

        var row5: TextAreaRow?
        row5 = self.form.rowBy(tag: "longDescriptionTag")
        let longDescriptionValue = row5?.value

        
        
        // 2
        let groceryItem = GroceryItem(creatorNameField: "unknown", titleField: titleValue!, locationNameField: "unknown", rankField: "unknown", timeField: "unknown", deadlineField: "unknown", priceField: "unknown", eventDateField: "\(eventDateValue!)", approvedRequestsCountField: "unknown", attendiesField: "unknown", shortDescriptionField: shortDescriptionValue!, creatorIDField: "unknown", startTimeField: "\(startTimeValue!)", endTimeField: "\(endTimeValue!)", addressField: "unknown", longDescriptionField: "\(longDescriptionValue!)", availableSpotsField: "\(availableSpotsValue!)")
        
        
        // 3
        let groceryItemRef = self.ref.child("IDK")
        
        // 4
        groceryItemRef.setValue(groceryItem.toAnyObject())
        
        //self.performSegue(withIdentifier: "mySegueID", sender: nil)
        
        
        //        }
        
        //        let cancelAction = UIAlertAction(title: "Cancel",
        //                                         style: .default)
        
        
        //        alert.addAction(saveAction)
        //        alert.addAction(cancelAction)
        //
        //        present(alert, animated: true, completion: nil)
        //
        //
        
        
    }
    
    
    func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

