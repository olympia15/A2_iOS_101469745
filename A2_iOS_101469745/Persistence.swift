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
        
        let products: [(name: String, description: String, price: Double, provider: String)] = [
            ("MacBook Pro", "High-performance laptop for professionals", 2499.99, "Apple"),
            ("Sony WH-1000XM6", "Noise cancelling headphones", 649.99, "Sony"),
            ("Samsung 4K Monitor", "27-inch UHD display", 599.99, "Samsung"),
            ("Playstation 5", "Gaming console", 799.99, "Sony"),
            ("iPad Air", "Powerful and colourful thin and light iPad", 749.99, "Apple"),
            ("Nintendo Switch 2", "Gaming console", 599.99, "Nintendo"),
            ("Anker USB-C Hub", "7-in-1 USB-C hub", 45.99, "Anker"),
            ("ROG Strix G16", "Gaming laptop", 999.99, "ASUS"),
            ("iPhone 17 Pro Max", "Silver 256GB", 1749.99, "Apple"),
            ("Kindle", "E-reader", 139.99, "Amazon")
        ]
        
        for item in products {
            let product = Product(context: context)
            product.productID = UUID()
            product.name = item.name
            product.productDescription = item.description
            product.price = item.price
            product.provider = item.provider
        }
        
        try? context.save()
    }
}
