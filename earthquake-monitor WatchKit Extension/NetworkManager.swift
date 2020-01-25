//
//  NetworkManager.swift
//  earthquake-monitor WatchKit Extension
//
//  Created by Joel Ibaceta on 1/22/20.
//  Copyright © 2020 Joel Ibaceta. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    func getEarthquakes() {
        
        let url_base = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let today = dateFormatterGet.string(from: Date())
        let yesterday = dateFormatterGet.string(
            from: Date().addingTimeInterval(-1*60*60*24)
        )
        let query_string = "starttime=\(yesterday)&endtime=\(today)"
        let url =  URL(string: "\(url_base)\(query_string)")!
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else { return }
            guard let data = data else { return }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
    }
}
