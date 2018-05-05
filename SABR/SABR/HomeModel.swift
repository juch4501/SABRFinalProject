//
//  HomeModel.swift
//  SABR
//
//  Created by Juan Chavez on 4/18/18.
//  Copyright © 2018 Juan Chavez. All rights reserved.
//

import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()

    var urlPath: String = "http://10.203.54.53:8080/middlelayer.php?"
    
    func downloadItems(firstName: String, lastName: String, seasonYear: String) {
        
        let url: URL = URL(string: urlPath + "FN=" + firstName + "&" + "LN=" + lastName + "&" + "YR=" + seasonYear + "&" + "TB=" + "1")!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }
            else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
        
        task.resume()
    }
    
    func downloadItemsWithWAR(firstName: String, lastName: String, seasonYear: String) {
        
        let url: URL = URL(string: urlPath + "FN=" + firstName + "&" + "LN=" + lastName + "&" + "YR=" + seasonYear + "&" + "TB=2")!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download WAR data")
            }
            else {
                print("Data downloadedWAR")
                self.parseJSON(data!)
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }
        catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let dataBlocks = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let cellBlock = DataModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let firstname = jsonElement["nameFirst"] as? String,
                let lasttname = jsonElement["nameLast"] as? String,
                let team = jsonElement["teamID"] as? String,
                let RCPPS = jsonElement["RCPPS"] as? String,
                let RC = jsonElement["RC"] as? String,
                let RP = jsonElement["RP"] as? String,
                let BWAR = jsonElement["bwar"] as? String,
                let PWAR = jsonElement["pwar"] as? String
            {
                
                cellBlock.firstname = firstname
                cellBlock.lastname = lasttname
                cellBlock.team = team
                cellBlock.RCPPS = RCPPS
                cellBlock.RC = RC
                cellBlock.RP = RP
                cellBlock.BWAR = BWAR
                cellBlock.PWAR = PWAR
            }
            dataBlocks.add(cellBlock)
        }
        DispatchQueue.main.async(execute:
            { () -> Void in
            self.delegate.itemsDownloaded(items: dataBlocks)
            })
    }
}
