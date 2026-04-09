//
//  ProductListView.swift
//  A2_iOS_101469745
//
//  Created by Olympia Santaguida-Antunes on 2026-04-09.
//

struct ProductListView: View {
    
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
            animation: .default
        ) private var products: FetchedResults<Product>
    
}
