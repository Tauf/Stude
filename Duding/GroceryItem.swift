

import Foundation
import Firebase


struct GroceryItem {
    var ref: DatabaseReference?
    let key: String
    
    
    var titleField: String
    
    var locationNameField: String
    
    
    var rankField: Int
    
    var timeField: String
    
    var deadlineField: String
    
    
    var priceField: String
    
    var eventDateField: String
    
    var approvedRequestsCountField: String
    
    
    //var postImage: UIImageView!
    
    //var creatorImage: UIImageView!
    
    //var creatorRating: UIImageView!
    
    
    var creatorNameField: String
    
    var creatorIDField: String
    
    var attendiesField: String
    
    var shortDescriptionField: String
    
    var startTimeField: String
    
    var endTimeField: String
    
    var addressField: String
    
    var availableSpotsField: String
    
    var longDescriptionField: String
    
    
    
    init(creatorNameField: String,
         titleField: String,
         
         locationNameField: String,
         
         
         rankField: Int,
         
         timeField: String,
         
         deadlineField: String,
         
         
         priceField: String,
         
         eventDateField: String,
         
         approvedRequestsCountField: String,
         
         
         attendiesField: String,
         
         shortDescriptionField: String,
         
         creatorIDField: String,
         
         startTimeField: String,
         
         endTimeField: String,
         
         addressField: String,
         
         longDescriptionField: String,
         
         availableSpotsField: String,
         
         key: String = "") {
        self.key = key
        self.creatorNameField = creatorNameField
        
        self.titleField = titleField
        
        self.locationNameField = locationNameField
        
        self.rankField = rankField
        
        self.timeField = timeField
        
        self.deadlineField = deadlineField
        
        self.priceField = priceField
        
        self.eventDateField = eventDateField
        
        self.approvedRequestsCountField = approvedRequestsCountField
        
        self.creatorNameField = creatorNameField
        
        self.creatorIDField = creatorIDField
        
        self.attendiesField = attendiesField
        
        self.shortDescriptionField = shortDescriptionField
        
        self.longDescriptionField = longDescriptionField
        
        self.startTimeField = startTimeField
        
        self.endTimeField = endTimeField
        
        self.addressField = addressField
        
        self.availableSpotsField = availableSpotsField
        
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        creatorNameField = "empty"
        
        
        titleField = "empty"
        
        locationNameField = "empty"
        
        
        rankField = 0
        
        timeField = "empty"
        
        deadlineField = "empty"
        
        
        priceField = "empty"
        
        eventDateField = "empty"
        
        approvedRequestsCountField = "empty"
        
        
        creatorIDField = "empty"
        
        attendiesField = "empty"
        
        shortDescriptionField = "empty"
        
        creatorIDField = "empty"
        
        startTimeField = "empty"
        
        endTimeField = "empty"
        
        addressField = "empty"
        
        availableSpotsField = "empty"
        
        longDescriptionField = "empty"
        
        availableSpotsField = "empty"
        
        
        for childSnap in  snapshot.children.allObjects {
            let snap = childSnap as! DataSnapshot
            if let snapshotValue = snapshot.value as? NSDictionary, let _ = snapshotValue[snap.key] as? AnyObject {
                
                
                
                titleField = snapshotValue["titleField"] as! String
                
                locationNameField = snapshotValue["locationNameField"] as! String
                
                
                rankField = (snapshotValue["rankField"]! as! NSString).integerValue
                
                timeField = snapshotValue["timeField"] as! String
                
                deadlineField = snapshotValue["deadlineField"] as! String
                
                
                priceField = snapshotValue["priceField"] as! String
                
                eventDateField = snapshotValue["eventDateField"] as! String
                
                approvedRequestsCountField = snapshotValue["approvedRequestsCountField"] as! String
                
                
                // postImage: UIImageView!
                
                // creatorImage: UIImageView!
                
                // creatorRating: UIImageView!
                
                
                creatorNameField = snapshotValue["creatorNameField"] as! String
                
                creatorIDField = snapshotValue["creatorIDField"] as! String
                
                attendiesField = snapshotValue["attendiesField"] as! String
                
                shortDescriptionField = snapshotValue["shortDescriptionField"] as! String
                
                longDescriptionField = snapshotValue["longDescriptionField"] as! String
                
                startTimeField = snapshotValue["startTimeField"] as! String
                
                endTimeField = snapshotValue["endTimeField"] as! String
                
                addressField = snapshotValue["addressField"] as! String
                
                availableSpotsField = snapshotValue["availableSpotsField"] as! String
                
                ref = snapshot.ref
            }
        }
        
        
        
    }
    
    func toAnyObject() -> Any {
        return [
            
            "titleField" : titleField,
            
            "locationNameField" : locationNameField,
            
            "rankField" : rankField,
            
            "timeField" : timeField,
            
            "deadlineField" : deadlineField,
            
            "priceField" : priceField,
            
            "eventDateField" : eventDateField,
            
            "approvedRequestsCountField" : approvedRequestsCountField,
            
            "creatorNameField" : creatorNameField,
            
            "creatorIDField" : creatorIDField,
            
            "attendiesField" : attendiesField,
            
            "shortDescriptionField" : shortDescriptionField,
            
            "longDescriptionField" : longDescriptionField,
            
            "startTimeField" : startTimeField,
            
            "endTimeField" : endTimeField,
            
            "addressField" : addressField,
            
            "availableSpotsField" : availableSpotsField,
            
        ]
        
    }
    
}
