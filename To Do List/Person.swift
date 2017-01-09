//
//  Person.swift
//  To Do List
//
//  Created by Phammel on 11/28/16.
//  Copyright © 2016 Phammel. All rights reserved.
//

import Foundation

import UIKit


class Person: NSObject, NSCoding
{
    
    var personName = ""
    var itemList = [Item]()
    
    required init?(coder aDecoder: NSCoder)
    {
        personName = aDecoder.decodeObject(forKey: "personName") as! String
        itemList = aDecoder.decodeObject(forKey: "itemList") as! [Item]
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(personName, forKey: "personName" )
        aCoder.encode(itemList, forKey: "itemList")
    }
    
    
    init(name: String)
    {
        
        self.personName = name
    }
    
    

}
