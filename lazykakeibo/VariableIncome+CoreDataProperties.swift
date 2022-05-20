//
//  VariableIncome+CoreDataProperties.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 19/05/22.
//
//

import Foundation
import CoreData


extension VariableIncome {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VariableIncome> {
        return NSFetchRequest<VariableIncome>(entityName: "VariableIncome")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: Float

}

extension VariableIncome : Identifiable {

}
