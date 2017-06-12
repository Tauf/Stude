//
//  MainTableViewController.swift
//

import UIKit
import FoldingCell
import UIKit
import Firebase
import FirebaseDatabaseUI



class MainTableViewController: UITableViewController {
  
  let kCloseCellHeight: CGFloat = 179
  let kOpenCellHeight: CGFloat = 488
  let kRowsCount = 10
  var cellHeights: [CGFloat] = []
    

    
    var items: [GroceryItem] = []
    let ref = Database.database().reference(withPath: "studyGroups/activePosts")
    let usersRef = Database.database().reference(withPath: "online")
    var user: User!
    var userCountBarButtonItem: UIBarButtonItem!
    
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    

    
    ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
        var newItems: [GroceryItem] = []
        
        for item in snapshot.children {
            let groceryItem = GroceryItem(snapshot: item as! DataSnapshot)
            newItems.append(groceryItem)
        }
        
        self.items = newItems
        self.tableView.reloadData()
    })

    
    
    setup()
  }
    
    
  private func setup() {
    cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
    tableView.estimatedRowHeight = kCloseCellHeight
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
  }
  
}

// MARK: - TableView
extension MainTableViewController {
  
    

    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return items.count
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard case let cell as DemoCell = cell else {
      return
    }
    
    cell.backgroundColor = .clear
    
    if cellHeights[indexPath.row] == kCloseCellHeight {
      cell.selectedAnimation(false, animated: false, completion:nil)
    } else {
      cell.selectedAnimation(true, animated: false, completion: nil)
    }
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! DemoCell
    let durations: [TimeInterval] = [0.26, 0.2, 0.2]
    cell.durationsForExpandedState = durations
    cell.durationsForCollapsedState = durations

    
    let groceryItem = items[indexPath.row]
    
    //cell.textLabel?.text = groceryItem.creator

 
    cell.titleField?.text = groceryItem.titleField
    
    cell.titleField2?.text = groceryItem.titleField
    
    cell.locationNameField?.text = groceryItem.locationNameField
    
    cell.locationNameField2?.text = groceryItem.locationNameField
    
    cell.rankField?.text = groceryItem.rankField
    
   //cell.relativeDayField?.text = groceryItem.creator
    
    cell.timeField?.text = groceryItem.timeField
    
   cell.deadlineField?.text = groceryItem.deadlineField
    
    cell.deadlineField2?.text = groceryItem.deadlineField
    
    cell.priceField?.text = groceryItem.priceField
    
    cell.priceField2?.text = groceryItem.priceField
    
    
    cell.eventDateField?.text = groceryItem.eventDateField
    
    cell.approvedRequestsCountField?.text = groceryItem.approvedRequestsCountField
    
    cell.approvedRequestsField2?.text = groceryItem.approvedRequestsCountField
    
    //cell.postImage?.text = groceryItem.creator
    
    //cell.creatorImage?.text = groceryItem.creator
    
    //cell.creatorRating?.text = groceryItem.creator
    
    cell.attendiesField?.text = groceryItem.attendiesField
    
    cell.shortDescriptionField?.text = groceryItem.shortDescriptionField
    
    cell.startTimeField?.text = groceryItem.startTimeField
    
    cell.endTimeField?.text = groceryItem.endTimeField
    
    cell.addressField?.text = groceryItem.addressField
    
    cell.creatorNameField?.text = groceryItem.creatorNameField
    //cell.leftSpotsField?.text = groceryItem.titleField
    


    
    
 
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeights[indexPath.row]
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
    
    if cell.isAnimating() {
      return
    }
    
    var duration = 0.0
    let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
    if cellIsCollapsed {
      cellHeights[indexPath.row] = kOpenCellHeight
      cell.selectedAnimation(true, animated: true, completion: nil)
      duration = 0.5
    } else {
      cellHeights[indexPath.row] = kCloseCellHeight
      cell.selectedAnimation(false, animated: true, completion: nil)
      duration = 0.8
    }
    
    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
      tableView.beginUpdates()
      tableView.endUpdates()
    }, completion: nil)
    
  }
  
}
