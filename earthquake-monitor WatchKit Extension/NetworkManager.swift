//
//  NetworkManager.swift
//  earthquake-monitor WatchKit Extension
//
//  Created by Joel Ibaceta on 1/22/20.
//  Copyright © 2020 Joel Ibaceta. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    
    func getEarthquakesList(callback: @escaping(NSArray) -> Void) {
        
        let url_base = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterGet.timeZone = TimeZone(secondsFromGMT: 0)
        
        let humanteDateFormatter = DateFormatter()
        humanteDateFormatter.timeZone = TimeZone.current
        humanteDateFormatter.dateFormat = "MMMM dd, yyyy '\n' HH:mm a"
        humanteDateFormatter.amSymbol = "AM"
        humanteDateFormatter.pmSymbol = "PM"
        
        let now = dateFormatterGet.string(from: Date())
        let lasthour = dateFormatterGet.string(
            from: Date().addingTimeInterval(-8*60*60)
        )
        
        let query_string = "starttime=\(lasthour)&endtime=\(now)&minmagnitude=4"
        let url =  URL(string: "\(url_base)\(query_string)")!
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in

            guard error == nil else { return }
            guard let data = data else { return }
                
            let eartquakes: NSMutableArray = []

            do {
                let json = try JSONSerialization.jsonObject(with: data)
                
                let eartquakesArray: NSArray = (json as! NSDictionary).value(forKey: "features") as! NSArray
                
                for (_, eartquake) in eartquakesArray.enumerated() {
                    
                    let eartquakeData: NSDictionary = (eartquake as! NSDictionary).value(forKey: "properties") as! NSDictionary
                    let magnitude = eartquakeData.value(forKey: "mag")
                    let location = eartquakeData.value(forKey: "place")
                    
                    let epochDate = (eartquakeData.value(forKey: "time") as! Double) / 1000.0
                    let timeZoneOffsetDate = Date(timeIntervalSince1970: epochDate)
                    let localDate = humanteDateFormatter.string(from: timeZoneOffsetDate)
                    
                    var scale_color = UIColor(red: CGFloat(176/255.0), green: CGFloat(207/255.0), blue: CGFloat(38/255.0), alpha: CGFloat(1.0))
                    
                    switch magnitude as! Double {
                        case 0.0..<4.5:
                            scale_color = UIColor(red: CGFloat(176/255.0), green: CGFloat(207/255.0), blue: CGFloat(38/255.0), alpha: CGFloat(1.0))
                        case 4.5..<6.0:
                            scale_color = UIColor(red: CGFloat(242/255.0), green: CGFloat(128/255.0), blue: CGFloat(25/255.0), alpha: CGFloat(1.0))
                        case 6.0..<8.0:
                            scale_color = UIColor(red: CGFloat(227/255.0), green: CGFloat(43/255.0), blue: CGFloat(23/255.0), alpha: CGFloat(1.0))
                        case 8.0..<10.0:
                            scale_color = UIColor(red: CGFloat(140/255.0), green: CGFloat(0/255.0), blue: CGFloat(64/255.0), alpha: CGFloat(1.0))
                        default:
                            // do nothing
                            break;
                    }
                    
                    eartquakes.add([
                        "magnitude": "\(magnitude ?? 0)",
                        "location": "\(location ?? "")",
                        "color": scale_color,
                        "datetime": localDate
                    ])
                    
                }
                
                callback(eartquakes)
            } catch let error {
                print(error.localizedDescription)
            }
            
        })
        task.resume()
        
    }
}
