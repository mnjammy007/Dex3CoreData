//
//  Dex3CoreDataApp.swift
//  Dex3CoreData
//
//  Created by Apple on 28/10/24.
//

import AppTrackingTransparency
import AppsFlyerLib
import SwiftUI

@main
struct Dex3CoreDataApp: App {
    
    init() {
        AppsFlyerLib.shared().appsFlyerDevKey = AppConfig.appsFlyerDevKeyTest
        AppsFlyerLib.shared().appleAppID = AppConfig.appleAppID
        AppsFlyerLib.shared().isDebug = true
        AppsFlyerLib.shared().isStopped = true
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        ATTrackingManager.requestTrackingAuthorization { _ in
                            AppsFlyerLib.shared().isStopped = false
                            AppsFlyerLib.shared().start()
                        }
                    }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
