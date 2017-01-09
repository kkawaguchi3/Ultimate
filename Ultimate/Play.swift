//
//  Play.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/3/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit
import os.log

class Play: NSObject,NSCoding {

    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var text: String?
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("plays")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let text = "text"
    }
    
    //MARK: Initialization

    init?(name: String, photo: UIImage, text: String) {
        // Initialization should fail if there is no name
        guard !name.isEmpty else {
            return nil
        }
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.text = text
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(text, forKey: PropertyKey.text)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cant decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Play object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let text = aDecoder.decodeObject(forKey: PropertyKey.text) as? String
        self.init(name: name, photo: photo!, text: text!)
        
    }

    
}
