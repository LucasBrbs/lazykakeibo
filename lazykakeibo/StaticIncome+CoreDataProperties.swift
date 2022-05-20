//
//  StaticIncome+CoreDataProperties.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 19/05/22.
//
//

import Foundation
import CoreData


extension StaticIncome {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StaticIncome> {
        return NSFetchRequest<StaticIncome>(entityName: "StaticIncome")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: Float

}

extension StaticIncome : Identifiable {

}
