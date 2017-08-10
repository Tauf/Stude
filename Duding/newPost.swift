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
    
    
    
    
    var rankField = 0 //: Int
    
    
    var sagee2 : String = ""
    
    
    
    var placesClient: GMSPlacesClient!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetController = segue.destination as! MainTableViewController
        
        targetController.sagee = self.sagee2
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref2: DatabaseReference
        
        if sagee2 == "study"
        {
            ref2 = Database.database().reference(withPath: "/studyGroups/activePosts")
            
            self.navigationItem.title = "New Study Group"
            

            
        }
        else if sagee2 == "hang"
        {
            
            ref2 = Database.database().reference(withPath: "/hangouts/activePosts")
            
            self.navigationItem.title = "New Hangout"
            
        }
        else if sagee2 == "local"
        {
            
            ref2 = Database.database().reference(withPath: "/localEvents/activePosts")
            
            self.navigationItem.title = "New Local Event"
            
        }
        else
        {
            
            ref2 = Database.database().reference(withPath: "/athleticEvents/activePosts")
            
            self.navigationItem.title = "New Athletic Event"
            
        }
        
        
        
        ref2.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.rankField = Int(snapshot.childrenCount) + 1
            
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
                    //let endRow: DateTimeInlineRow! = self?.form.rowBy(tag: "endTimeTag")
                    //if row.value?.compare(endRow.value!) == .orderedDescending {
                    //endRow.value = Date(timeInterval: 60*60*24, since: row.value!)
                    //endRow.cell!.backgroundColor = .white
                    row.updateCell()
                    //}
            }
            
            
            <<< TimeRow("endTimeTag"){
                $0.title = "End Time"
                $0.value = Date().addingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    //                    let startRow: DateTimeInlineRow! = self?.form.rowBy(tag: "startTimeTag")
                    //                    if row.value?.compare(startRow.value!) == .orderedAscending {
                    //                        row.cell!.backgroundColor = .red
                    //                    }
                    //                    else{
                    //                        row.cell!.backgroundColor = .white
                    //                    }
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
        
        
        
        
        
        let calendar = NSCalendar.autoupdatingCurrent
        
        
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
        let titleValue = row?.value ?? "untitled"
        
        row = self.form.rowBy(tag: "shortDescriptionTag")
        let shortDescriptionValue = row?.value ?? "no summary"
        var row2: StepperRow?
        
        row2 = self.form.rowBy(tag: "availableSpotsTag")
        let availableSpotsValue = row2?.value ?? 1
        
        var row3: DateRow?
        row3 = self.form.rowBy(tag: "eventDateTag")
        let eventDateValue_temp = row3?.value
        
        let dateComponents_4 = calendar.dateComponents([.month, .year, .day], from: eventDateValue_temp!)
        let eventDateValue =  "\(String(describing: dateComponents_4.month!))/\(String(describing: dateComponents_4.day!))/\(String(describing: dateComponents_4.year!))"
        
        
        
        
        row3 = self.form.rowBy(tag: "deadlineTag")
        let deadlineValue_temp = row3?.value
        
        let dateComponents_3 = calendar.dateComponents([.month, .year, .day], from: deadlineValue_temp!)
        let deadlineValue =  "\(String(describing: dateComponents_3.month!))/\(String(describing: dateComponents_3.day!))/\(String(describing: dateComponents_3.year!))"
        
        
        
        var row4: TimeRow?
        
        row4 = self.form.rowBy(tag: "startTimeTag")
        let startTimeValue_temp = row4?.value
        
        let dateComponents = calendar.dateComponents([.hour, .minute], from: startTimeValue_temp!)
        let startTimeValue =  "\(String(describing: dateComponents.hour!)):\(String(describing: dateComponents.minute!))"
        
        
        
        row4 = self.form.rowBy(tag: "endTimeTag")
        let endTimeValue_temp = row4?.value
        
        let dateComponents_2 = calendar.dateComponents([.hour, .minute], from: endTimeValue_temp!)
        let endTimeValue =  "\(String(describing: dateComponents_2.hour!)):\(String(describing: dateComponents_2.minute!))"
        
        
        
        var row5: TextAreaRow?
        row5 = self.form.rowBy(tag: "longDescriptionTag")
        let longDescriptionValue = row5?.value ?? "undescribed"
        
        
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            let email = user.email
            
            var token = email?.components(separatedBy: "@")
            let userName = token?[0] ?? "no username"
            
            //let photoURL = user.photoURL
            
            let userID = Auth.auth().currentUser?.uid
            
            
            
            
            
            let groceryItem : Dictionary<String, Any> = ["creatorNameField": "\(userName)", "titleField": titleValue, "locationNameField": "unlocated", "rankField":"\(rankField)" , "timeField": "\(startTimeValue)", "deadlineField": "\(deadlineValue)", "priceField": "Free", "eventDateField": "\(eventDateValue)", "approvedRequestsCountField": "0", "attendiesField": "unknown", "shortDescriptionField": "\(shortDescriptionValue)", "creatorIDField": "unknown", "startTimeField": "\(startTimeValue)", "endTimeField": "\(endTimeValue)", "addressField": "unknown", "longDescriptionField": "\(longDescriptionValue)", "availableSpotsField": "\(availableSpotsValue)"]
            
            
            let ref = Database.database().reference(withPath: "/")
            
            var key = ref.child("studyGroups/activePosts/").childByAutoId().key
            var childUpdates = ["studyGroups/activePosts/\(key)": groceryItem,
                                    "users/\(String(describing: userID))/\(key)/": groceryItem]
            
            if sagee2 == "study"
            {
                
                key = ref.child("studyGroups/activePosts/").childByAutoId().key
                childUpdates = ["studyGroups/activePosts/\(key)": groceryItem,
                                "users/\(String(describing: userID))/\(key)/": groceryItem]
                


                
                
            }
            else if sagee2 == "hang"
            {
                
                key = ref.child("hangouts/activePosts/").childByAutoId().key
                childUpdates = ["hangouts/activePosts/\(key)": groceryItem,
                                "users/\(String(describing: userID))/\(key)/": groceryItem]
                
                
                
                
                
            }
            else if sagee2 == "local"
            {
                
                key = ref.child("localEvents/activePosts/").childByAutoId().key
                childUpdates = ["localEvents/activePosts/\(key)": groceryItem,
                                "users/\(String(describing: userID))/\(key)/": groceryItem]
                
                
                
            }
            else
            {
                
                key = ref.child("athleticEvents/activePosts/").childByAutoId().key
                childUpdates = ["athleticEvents/activePosts/\(key)": groceryItem,
                                "users/\(String(describing: userID))/\(key)/": groceryItem]
                
                
            }
 
            
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
        
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("Place name \(place.name)")
        print("Place address \(String(describing: place.formattedAddress))")
        print("Place attributions \(String(describing: place.attributions))")
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

