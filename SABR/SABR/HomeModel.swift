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
    
    var urlPath: String = "http://localhost:8080/middlelayer.php?" //this will be changed to the path where service.php lives
    
    func downloadItems(firstName: String, lastName: String) {
        
        let url: URL = URL(string: urlPath + "FN=" + firstName + "&" + "LN=" + lastName)!
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
            if let firstname = jsonElement["FirstName"] as? String,
                let lasttname = jsonElement["LastName"] as? String,
                let RCPPS = jsonElement["Address"] as? String, //change names to what JSON says
                let RC = jsonElement["Latitude"] as? String //change names to what JSON says
            {
                
                cellBlock.firstname = firstname
                cellBlock.lastname = lasttname
                cellBlock.RCPPS = RCPPS
                cellBlock.RC = RC
            }
            dataBlocks.add(cellBlock)
        }
        DispatchQueue.main.async(execute:
            { () -> Void in
            self.delegate.itemsDownloaded(items: dataBlocks)
            })
    }
}
