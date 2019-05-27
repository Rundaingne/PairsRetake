//
//  EntityController.swift
//  PairsRetake
//
//  Created by Brooke Kumpunen on 5/27/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import Foundation


class EntityController {
    
    static let shared = EntityController()
    private init() {}
    
    var entities: [Entity] = []
    
    var pairs: [[Entity]] {
        var shuffledEntities = entities.shuffled()
        var bigArray: [[Entity]] = []
        var smallArray: [Entity] = []

        while !shuffledEntities.isEmpty {
            if smallArray.count == 2 {
                let copyArray = smallArray
                bigArray.append(copyArray)
                smallArray = []
            }
            smallArray.append(shuffledEntities.removeLast())
        }
        if !smallArray.isEmpty {
            bigArray.append(smallArray)
        }
        return bigArray
    }
    
//    var realPairs: [[Entity]] {
//        var newPairs: [[Entity]] = []
//        var pair: [Entity] = []
//        var copy = entities
//        //Check if any entities are the same.
//        let randomIndex = Int.random(in: 0..<copy.count)
//        let original = copy.remove(at: randomIndex)
//        while !copy.isEmpty {
//            if pair.count == 2 {
//                let copy = pair
////                pair.append(copy)
//                pair = []
//            }
//            if original == copy.remove(at: randomIndex) {
//                assert(false)
//            } else {
//                pair.append(copy.remove(at: randomIndex))
//            }
//
//
//        }
//        return newPairs
//    }
    
    func createEntity(name: String, grouping: String?) {
        let entity = Entity(name: name, grouping: grouping)
        entities.append(entity)
        save()
    }
    
    func deleteEntity(entity: Entity) {
        guard let index = entities.firstIndex(of: entity) else {return}
        entities.remove(at: index)
        save()
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "name.json"
        let fullURL = documentsDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(entities)
            try data.write(to: fileURL())
        } catch {
            print("There was an error in \(#function): \(error) \(error.localizedDescription)")
        }
    }
    
    func load() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let entities = try decoder.decode([Entity].self, from: data)
            self.entities = entities
        } catch {
            print("There was an error in \(#function): \(error) \(error.localizedDescription)")
        }
    }
}
