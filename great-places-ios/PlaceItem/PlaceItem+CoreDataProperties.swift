//
//  PlaceItem+CoreDataProperties.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 09/06/24.
//
//

import Foundation
import CoreData


extension PlaceItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceItem> {
        return NSFetchRequest<PlaceItem>(entityName: "PlaceItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var address: String?
    @NSManaged public var image: Data?

}

extension PlaceItem : Identifiable {

}
