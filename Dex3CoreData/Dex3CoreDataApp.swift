//
//  Dex3CoreDataApp.swift
//  Dex3CoreData
//
//  Created by Apple on 28/10/24.
//

import SwiftUI

@main
struct Dex3CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
