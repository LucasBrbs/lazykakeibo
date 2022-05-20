//
//  VariableBill+CoreDataProperties.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 19/05/22.
//
//

import Foundation
import CoreData


extension VariableBill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VariableBill> {
        return NSFetchRequest<VariableBill>(entityName: "VariableBill")
    }

    @NSManaged public var name: String?
    @NSManaged public var bill: Float

}

extension VariableBill : Identifiable {

}
