//
//  LocationViewModel.swift
//  MapVirtualTurist
//
//  Created by Elisangela Pethke on 10.07.24.
//

import SwiftUI
import CoreData
import MapKit

class LocationViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var locations: [UserLocation] = []
    @Published var selectedLocation: UserLocation?

    private let context = PersistenceController.shared.container.viewContext

    init() {
        fetchLocations()
    }

    func fetchLocations() {
        let request: NSFetchRequest<UserLocation> = UserLocation.fetchRequest()
        do {
            locations = try context.fetch(request)
        } catch {
            print("Failed to fetch locations: \(error)")
        }
    }

    func addLocation(latitude: Double, longitude: Double, photo: Data?) {
        let newLocation = UserLocation(context: context)
        newLocation.latitude = latitude
        newLocation.longitude = longitude
        newLocation.photo = photo

        saveContext()
    }

    func deleteLocation(location: UserLocation) {
        context.delete(location)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
            fetchLocations()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

