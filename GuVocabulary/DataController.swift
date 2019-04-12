//
//  DataController.swift
//  GuVocabulary
//
//  Created by 白小菲528 on 2019-03-11.
//  Copyright © 2019 xiongma. All rights reserved.
//

import Foundation

class DataController {
    //static let sharedInstance: DataController =  DataController()
    
    static var data = Dictionary<String, Dictionary<String, [String]>>()

    static func getData() -> Dictionary<String, Dictionary<String, [String]>> {
        return data
    }
}
