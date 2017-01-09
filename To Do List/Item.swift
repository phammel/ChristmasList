//
//  Item.swift
//  To Do List
//
//  Created by Phammel on 11/28/16.
//  Copyright © 2016 Phammel. All rights reserved.
//

import Foundation

import UIKit


class Item: NSObject, NSCoding
{
    // url, picture, name, price
    
    var image = "lilguy"
    var url = ""
    var itemName = ""
    var price: Double = 0.00
    var done = true
    var priority = ""
    
    required init?(coder aDecoder: NSCoder)
    {
        //personName = aDecoder.decodeObject(forKey: "personName") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
        url = aDecoder.decodeObject(forKey: "url") as! String
        itemName = aDecoder.decodeObject(forKey: "itemName") as! String
        priority = aDecoder.decodeObject(forKey: "priority") as! String
        price = aDecoder.decodeDouble(forKey: "price")
        done = aDecoder.decodeBool(forKey: "done")
        

        
    }
    func encode(with aCoder: NSCoder)
    {
        //aCoder.encode(personName, forKey: "personName" )
        aCoder.encode(image, forKey: "image" )
        aCoder.encode(url, forKey: "url" )
        aCoder.encode(itemName, forKey: "itemName" )
        aCoder.encode(priority, forKey: "priority" )
        aCoder.encode(price, forKey: "price" )
        aCoder.encode(done, forKey: "done" )
        
        
        
    }
    

    init(url: String, image: String, name: String, price: Double,priority: String )
    {
        self.url = url
        self.image = image
        self.itemName = name
        self.price = price
        done = true
        self.priority = priority
        
    }
    
        
    
    
    
    
}
