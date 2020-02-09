//
//  RowController.swift
//  earthquake-monitor WatchKit Extension
//
//  Created by Joel Ibaceta on 1/21/20.
//  Copyright © 2020 Joel Ibaceta. All rights reserved.
//

import Foundation
import WatchKit

class RowController: NSObject {
    
    @IBOutlet weak var magnitudeLabel: WKInterfaceLabel!
    @IBOutlet weak var locationLabel: WKInterfaceLabel!
    @IBOutlet weak var datetimeLabel: WKInterfaceLabel!
    
}
