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
            TabView{
                DetailView()
                    .tabItem{
                        Label("Browse", systemImage: "rectangle.on.rectangle")
                    }
                
                ProductListView()
                    .tabItem{
                        Label("All Products", systemImage: "list.bullet")
                    }
                
                SearchView()
                    .tabItem{
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
