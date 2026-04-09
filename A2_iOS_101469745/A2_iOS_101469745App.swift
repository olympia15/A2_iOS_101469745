//
//  A2_iOS_101469745App.swift
//  A2_iOS_101469745
//
//  Created by Olympia Santaguida-Antunes on 2026-04-09.
//

import SwiftUI
import CoreData

@main
struct A2_iOS_101469745App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DetailView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
