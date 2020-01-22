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
        // Configure interface objects here.
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
        uitable.setNumberOfRows(8, withRowType: "RowController")
    }

}
