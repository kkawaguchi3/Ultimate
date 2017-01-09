//
//  Workout.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/6/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit
import os.log

class Workout: NSObject, NSCoding {
    
    // MARK: Properties
    var name: String
    var type: String?
    var descript: String?
    
    struct PropertyKey {
        static let name = "name"
        static let type = "type"
        static let descript = "descript"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("workouts")
    
    
    // MARK: Initialization
    init?(name: String, type: String, descript: String) {
        // Do not initialize if workout does not have a name
        if name.isEmpty {
            return nil
        }
        self.name = name
        self.type = type
        self.descript = descript
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(type, forKey: PropertyKey.type)
        aCoder.encode(descript, forKey: PropertyKey.descript)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let type = aDecoder.decodeObject(forKey: PropertyKey.type) as? String
        
        let descript = aDecoder.decodeObject(forKey: PropertyKey.descript) as? String
        
        // Must call designated initializer.
        self.init(name: name, type: type!, descript: descript!)
        
    }
}
