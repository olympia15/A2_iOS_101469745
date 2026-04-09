//
//  Persistence.swift
//  A2_iOS_101469745
//
//  Created by Olympia Santaguida-Antunes on 2026-04-09.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    init (inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_101469745")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores{ _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        seedProductsIfNeeded()
    }
    
    // helper function to seed db
    private func seedProductsIfNeeded() {
        let context = container.viewContext
        
        // only seed if the database is empty
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let count = (try? context.count(for: fetchRequest)) ?? 0
        guard count == 0 else { return }
    }
}
