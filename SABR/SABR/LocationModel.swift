//
//  LocationModel.swift
//  SABR
//
//  Created by Juan Chavez on 4/18/18.
//  Copyright © 2018 Juan Chavez. All rights reserved.
//

import Foundation

class LocationModel: NSObject {
    
    //properties
    
    var firstname: String!
    var lastname: String!
    var address: String!
    var latitude: String!
    var longitude: String!
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(firstname: String, lastname: String, address: String, latitude: String, longitude: String) {
        
        self.firstname = firstname
        self.lastname = lastname
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        
    }
    

    
    
}
