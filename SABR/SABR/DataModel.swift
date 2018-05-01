//
//  LocationModel.swift
//  SABR
//
//  Created by Juan Chavez on 4/18/18.
//  Copyright © 2018 Juan Chavez. All rights reserved.
//

import Foundation

class DataModel: NSObject {
    
    //properties
    
    var firstname: String!
    var lastname: String!
    var RCPPS: String!
    var RC: String!
    //var longitude: String!
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(firstname: String, lastname: String, RCPPS: String, RC: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.RCPPS = RCPPS
        self.RC = RC
    }
}
