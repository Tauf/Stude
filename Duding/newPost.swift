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
import GooglePlacePicker
import GoogleMaps
import GooglePlaces


typealias Emoji = String
let 👦🏼 = "👦🏼", 🍐 = "🍐", 💁🏻 = "💁🏻", 🐗 = "🐗", 🐼 = "🐼", 🐻 = "🐻", 🐖 = "🐖", 🐡 = "🐡"



class newPost:FormViewController {
    
    
    let ref = Database.database().reference(withPath: "/")
    
    let ref2 = Database.database().reference(withPath: "/studyGroups/activePosts")
    
    var rankField = 0 //: Int


    
    
    
    
    var placesClient: GMSPlacesClient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref2.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.rankField = Int(snapshot.childrenCount) + 1
            
            print("avval")
            print(self.rankField)
        })
        
        
        placesClient = GMSPlacesClient.shared()
        
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
            
            
            //            <<< LocationRow("locationTag"){
            //                $0.title = "Meeting Place"
            //                $0.value = CLLocation(latitude: 37.872488, longitude: -122.260841)
            //            }
            
            
            
            
            
            <<< ImageRow(){
                $0.title = "Post Background"
            }
            <<< ButtonRow("locationTag"){
                $0.title = "Meeting Place"
                $0.value = "tap to select"
                } .onCellSelection { cell, row in
                    
                    
                    let config = GMSPlacePickerConfig(viewport: nil)
                    let placePicker = GMSPlacePickerViewController(config: config)
                    self.present(placePicker, animated: true, completion: nil)
                    
                    //                    self.placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
                    //                        if let error = error {
                    //                            print("Pick Place error: \(error.localizedDescription)")
                    //                            return
                    //                        }
                    //
                    //
                    //                        if let placeLikelihoodList = placeLikelihoodList {
                    //                            let place = placeLikelihoodList.likelihoods.first?.place
                    //                            if let place = place {
                    //                                row.title = place.name
                    //
                    //                                //                                self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                    //                                //                                    .joined(separator: "\n")
                    //                            }
                    //                        }
                    //                    })
                    //
                    row.reload() // or row.updateCell()
            }
            
            <<< TextRow("shortDescriptionTag") {
                $0.title = "Event Summary"
                $0.placeholder = "Short Description"
            }
            
            <<< TextAreaRow("longDescriptionTag") {
                $0.placeholder = "Details"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 110)
            }
            
            <<< DateRow("deadlineTag") {
                
                $0.value = Date()
                $0.title = "RSVP Deadline"
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
        
        row3 = self.form.rowBy(tag: "deadlineTag")
        let deadlineValue = row3?.value
        
        var row4: TimeRow?
        
        row4 = self.form.rowBy(tag: "startTimeTag")
        let startTimeValue = row4?.value
        
        row4 = self.form.rowBy(tag: "endTimeTag")
        let endTimeValue = row4?.value
        
        var row5: TextAreaRow?
        row5 = self.form.rowBy(tag: "longDescriptionTag")
        let longDescriptionValue = row5?.value
        


        
        
        print("dovvom")
        print(rankField)
        
        let groceryItem : Dictionary<String, Any> = ["creatorNameField": "unknown", "titleField": titleValue!, "locationNameField": "unknown", "rankField":"\(rankField)" , "timeField": "unknown", "deadlineField": "\(deadlineValue!)", "priceField": "Free", "eventDateField": "\(eventDateValue!)", "approvedRequestsCountField": "unknown", "attendiesField": "unknown", "shortDescriptionField": "\(shortDescriptionValue!)", "creatorIDField": "unknown", "startTimeField": "\(startTimeValue!)", "endTimeField": "\(endTimeValue!)", "addressField": "unknown", "longDescriptionField": "\(longDescriptionValue!)", "availableSpotsField": "\(availableSpotsValue!)"]
        
        
        
        let key = ref.child("studyGroups/activePosts/").childByAutoId().key
        
        let userID = Auth.auth().currentUser?.uid
        
        let childUpdates = ["studyGroups/activePosts/\(key)": groceryItem,
                            "users/\(String(describing: userID))/\(key)/": groceryItem]
        ref.updateChildValues(childUpdates)
        
        
        //let groceryItemRef = self.ref.child("IDK")
        
        // 4
        //groceryItemRef.setValue(groceryItem.toAnyObject())
        
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
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("Place name \(place.name)")
        print("Place address \(place.formattedAddress)")
        print("Place attributions \(place.attributions)")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
    func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

