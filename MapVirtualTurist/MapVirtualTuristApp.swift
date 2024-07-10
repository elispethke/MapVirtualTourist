//
//  MapVirtualTuristApp.swift
//  MapVirtualTurist
//
//  Created by Elisangela Pethke on 10.07.24.
//

import SwiftUI

@main
struct MapVirtualTuristApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
