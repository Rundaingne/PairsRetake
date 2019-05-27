//
//  PairsTableViewController.swift
//  PairsRetake
//
//  Created by Brooke Kumpunen on 5/27/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import UIKit

class PairsTableViewController: UITableViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var entityNameTextField: UITextField!
    @IBOutlet weak var entityGroupingTextField: UITextField!
    
    
    let entities = EntityController.shared.entities

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return EntityController.shared.pairs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pair = EntityController.shared.pairs[section]
       return pair.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pairCell", for: indexPath)
        let pair = EntityController.shared.pairs[indexPath.section]
        let entity = pair[indexPath.row]
        cell.textLabel?.text = entity.name
        cell.detailTextLabel?.text = entity.grouping
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group number: \(section + 1)"
    }
    
    func randomize(entities: [Entity]) {
        //I need to first shuffle the array of entities, and then reload the data.
        for _ in 0..<entities.count {
            
        }
        var copy = entities
        copy.sort{_,_ in (arc4random() < arc4random())}
        copy = entities
        self.tableView.reloadData()
    }
    
//    func realRandomize(entities: [Entity]) {
////        var copy = entities
//        var newEntities: [Entity] = []
//        //I need to move things around in this array.
//        for entity in entities {
//            newEntities.insert(entity, at: 2)
//        }
//        EntityController.shared.entities = newEntities
//        self.tableView.reloadData()
//    }
    
    //MARK: -Actions
    @IBAction func addEntityButtonTapped(_ sender: UIButton) {
        guard let name = entityNameTextField.text, name != "", let grouping = entityGroupingTextField.text else {return}
        EntityController.shared.createEntity(name: name, grouping: grouping)
        entityNameTextField.text = ""
        entityGroupingTextField.text = ""
        self.tableView.reloadData()
    }
    
    @IBAction func randomizePairsButtonTapped(_ sender: UIButton) {
        randomize(entities: EntityController.shared.entities)
//        realRandomize(entities: EntityController.shared.entities)
    }
    
}
