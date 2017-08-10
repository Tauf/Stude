//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import UIKit
import FoldingCell

class DemoCell:  FoldingCell  {
    
    
    
    @IBOutlet weak var joinButtonOutlet: UIButton!
    @IBOutlet weak var titleField: UILabel!
    
    @IBOutlet weak var titleField2: UILabel!
    
    @IBOutlet weak var locationNameField: UILabel!
    
    @IBOutlet weak var locationNameField2: UILabel!
    
    @IBOutlet weak var rankField: UILabel!
    
    @IBOutlet weak var relativeDayField: UILabel!
    
    @IBOutlet weak var timeField: UILabel!
    
    @IBOutlet weak var deadlineField: UILabel!
    
    @IBOutlet weak var deadlineField2: UILabel!
    
    @IBOutlet weak var priceField: UILabel!
    
    @IBOutlet weak var priceField2: UILabel!
    
    @IBOutlet weak var eventDateField: UILabel!
    
    @IBOutlet weak var approvedRequestsCountField: UILabel!
    
    @IBOutlet weak var approvedRequestsField2: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var creatorImage: UIImageView!
    
    @IBOutlet weak var creatorRating: UIImageView!
    
    @IBOutlet weak var attendiesField: UILabel!
    
    @IBOutlet weak var shortDescriptionField: UILabel!
    
    @IBOutlet weak var startTimeField: UILabel!
    
    @IBOutlet weak var endTimeField: UILabel!
    
    @IBOutlet weak var addressField: UILabel!
    
    @IBOutlet weak var leftSpotsField: UILabel!
    
    @IBOutlet weak var creatorNameField: UILabel!
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26*2.5, 0.2*2.5, 0.2*2.5]
        return durations[itemIndex]
    }
    
}

// MARK: - Actions ⚡️
extension DemoCell {
    
    
    @IBAction func buttonHandler(_ sender: AnyObject) {
        if joinButtonOutlet.titleLabel!.text == "Send A Request to Join" {
            joinButtonOutlet.setTitle("Your request is pending host approval, also .edu email confirmation is required...", for: .normal)
            joinButtonOutlet.isHighlighted = true
        }
        else{
            joinButtonOutlet.setTitle("Send A Request to Join", for: .normal)
            joinButtonOutlet.isHighlighted = false

            
        }
    }
    
    
    
}
