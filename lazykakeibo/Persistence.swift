//
//  Persistence.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 19/05/22.
//

import CoreData

struct PersistentController{
    static let shared = PersistentController()
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error: \(error)")
            }
        })
    }
}
