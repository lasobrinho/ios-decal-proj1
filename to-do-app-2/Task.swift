//
//  Task.swift
//  to-do-app-2
//
//  Created by Lucas Alves Sobrinho on 2/20/16.
//  Copyright © 2016 Lucas Alves Sobrinho. All rights reserved.
//

import UIKit

class Task: NSObject {
    
    // MARK: Properties
    
    var name: String
    var status: Bool
    var dateAdded: NSDate
    var dateCompleted: NSDate?
    var color: UIColor
    
    // MARK: Initialization
    
    init?(name: String) {
        self.name = name
        self.status = false
        dateAdded = NSDate()
        color = UIColor.whiteColor()
    }
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.status = aDecoder.decodeBoolForKey("status")
        self.dateCompleted = aDecoder.decodeObjectForKey("dateCompleted") as? NSDate
        self.dateAdded = aDecoder.decodeObjectForKey("dateAdded") as! NSDate
        self.color = aDecoder.decodeObjectForKey("color") as! UIColor
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeBool(status, forKey: "status")
        aCoder.encodeObject(dateCompleted, forKey: "dateCompleted")
        aCoder.encodeObject(dateAdded, forKey: "dateAdded")
        aCoder.encodeObject(color, forKey: "color")
    }
    
}
