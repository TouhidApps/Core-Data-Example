//
//  Student+CoreDataProperties.swift
//  CoreDataiOS
//
//  Created by Touhid on 7/23/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?

}
