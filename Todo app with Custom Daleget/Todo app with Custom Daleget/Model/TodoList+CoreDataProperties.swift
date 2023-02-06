//
//  TodoList+CoreDataProperties.swift
//  Todo app with Custom Daleget
//
//  Created by Appnotrix on 18/1/23.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var todoTitle: String?
    @NSManaged public var todoDescription: String?

}

extension TodoList : Identifiable {

}
