//
//  Entity.swift
//  PairsRetake
//
//  Created by Brooke Kumpunen on 5/27/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import Foundation

class Entity: Codable {
    
    var name: String
    var grouping: String?
    let timestamp: Date
    
    init(name: String, grouping: String?, timestamp: Date = Date()) {
        self.name = name
        self.grouping = grouping
        self.timestamp = timestamp
    }
}

extension Entity: Equatable {
    static func ==(lhs: Entity, rhs: Entity) -> Bool {
        return lhs.name == rhs.name && lhs.grouping == rhs.grouping && lhs.timestamp == rhs.timestamp
    }
}
