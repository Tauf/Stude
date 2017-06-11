//
//  NewStudy.swift
//  Duding
//
//  Created by parsataleb on 6/8/17.
//  Copyright © 2017 parsataleb. All rights reserved.
//

import Foundation
import UIKit
import DatePickerDialog
import IBAnimatable
import UIKit
import GooglePlacePicker
import GoogleMaps
import GooglePlaces


class NewStudy: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var dateField: AnimatableButton!
    

    @IBOutlet var startTimeField: AnimatableButton!
    
    @IBOutlet var endTimeField: AnimatableButton!
    
    @IBOutlet var notifactionField: AnimatableButton!
    
    
    @IBOutlet var locationField: AnimatableButton!
    
    @IBAction func dateFieldTap(_ sender: Any) {
        
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let oneMonthLater = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        
        
        DatePickerDialog().show(title: "Session Date", doneButtonTitle: "Done", minimumDate:  currentDate, maximumDate: oneMonthLater, datePickerMode: .date) {
            (date) -> Void in
            
            if date != nil {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE MM/dd/yyyy"

                
                self.dateField.setTitle("\(formatter.string(from: date!))", for: .normal)

                
            }
            
        }
        
    }
    
    
    @IBAction func startTimeTap(_ sender: Any) {
        
        DatePickerDialog().show(title: "Session Start Time", doneButtonTitle: "Done", datePickerMode: .time) {
            (date) -> Void in
            
            if date != nil {
                let formatter = DateFormatter()
                formatter.dateFormat = "H:MM a"
                self.startTimeField.setTitle("\(formatter.string(from: date!))", for: .normal)
                
            }
            
        }
        
    }
    
   
    @IBAction func endTimeTap(_ sender: Any) {
        
        DatePickerDialog().show(title: "Session End Time", doneButtonTitle: "Done", datePickerMode: .time) {
            (date) -> Void in
            
            if date != nil {
                let formatter = DateFormatter()
                formatter.dateFormat = "H:MM a"
                self.endTimeField.setTitle("\(formatter.string(from: date!))", for: .normal)
                
            }
            
        }
        
        
    }

    

    @IBAction func notificationTap(_ sender: Any) {
        
        
    }
    
    
    @IBAction func locationTap(_ sender: Any) {
        
        
//        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
//        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
//        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
//        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
//        let config = GMSPlacePickerConfig(viewport: viewport)
//        let placePicker = GMSPlacePicker(config: config)
//        
//        placePicker.pickPlace(callback: {(place, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let place = place {
//                self.locationField.setTitle(place.name, for: .normal)
//
//            } else {
//                self.locationField.setTitle("select", for: .normal)
//            }
//        })
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = PickAPlaceViewController()
        let splitPaneViewController = SplitPaneViewController(rootViewController: rootViewController)
        
        // Wrap the split pane controller in a inset controller to get the map displaying behind our
        // content on iPad devices.
        let mapController = BackgroundMapViewController()
        rootViewController.mapViewController = mapController
        let insetController = InsetViewController(backgroundViewController: mapController,
                                                  contentViewController: splitPaneViewController)
        window.rootViewController = insetController
        
        // Make the window visible and allow the app to continue initialization.
        window.makeKeyAndVisible()
        //self.window = window

        
    }
    
    
    
}


