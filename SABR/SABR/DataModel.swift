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
    var team: String!
    var RCPPS: String?
    var RC: String!
    var RP: String!
    var BWAR: String?
    var PWAR: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(firstname: String, lastname: String, team: String, RCPPS: String, RC: String, RP: String, BWAR: String, PWAR: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.team = team
        self.RCPPS = RCPPS
        self.RC = RC
        self.RP = RP
        self.BWAR = BWAR
        self.PWAR = PWAR
    }
}
