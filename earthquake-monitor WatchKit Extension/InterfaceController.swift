//
//  InterfaceController.swift
//  earthquake-monitor WatchKit Extension
//
//  Created by Joel Ibaceta on 1/12/20.
//  Copyright © 2020 Joel Ibaceta. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var uitable: WKInterfaceTable!
    
    let tableData = ["8.4", "6km SSW of Big Lake, Alaska", "9/9/14 12:09 PM"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadTableData()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadTableData() {
        
        let client = NetworkManager.init()
        
        client.getEarthquakesList(callback: { (eartquakes) -> Void in
          
            self.uitable.setNumberOfRows(eartquakes.count, withRowType: "RowController")
            
            for (index, eartquake) in eartquakes.enumerated() {
                 
                if let rowController = self.uitable.rowController(at: index) as? RowController {
                    
                    let magnitude = (eartquake as! NSDictionary).value(forKey: "magnitude")
                    let color: UIColor = (eartquake as! NSDictionary).value(forKey: "color") as! UIColor
                    rowController.magnitudeLabel.setText("\(magnitude ?? 0)")
                    rowController.magnitudeLabel.setTextColor(color)
                    let location = (eartquake as! NSDictionary).value(forKey: "location")
                    rowController.locationLabel.setText("\(location ?? "")")
                    let datetime = (eartquake as! NSDictionary).value(forKey: "datetime")
                    rowController.datetimeLabel.setText("\(datetime ?? "")")
                    
                }
                
            }
            
        })
    }
    
    private func reloadTable(){
        
    }

}
