//
//  Location.swift
//  MapVirtualTurist
//
//  Created by Elisangela Pethke on 10.07.24.
//

import CoreData

@objc(UserLocation)
public class UserLocation: NSManagedObject {
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var photo: Data?
}

extension UserLocation: Identifiable {
    public var id: NSManagedObjectID { objectID }
}

extension UserLocation {
    static func fetchRequest() -> NSFetchRequest<UserLocation> {
        return NSFetchRequest<UserLocation>(entityName: "UserLocation")
    }
}
