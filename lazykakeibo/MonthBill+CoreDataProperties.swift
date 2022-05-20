//
//  MonthBill+CoreDataProperties.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 19/05/22.
//
//

import Foundation
import CoreData


extension MonthBill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonthBill> {
        return NSFetchRequest<MonthBill>(entityName: "MonthBill")
    }

    @NSManaged public var name: String?
    @NSManaged public var bill: Float
    

}

extension MonthBill : Identifiable {

}
