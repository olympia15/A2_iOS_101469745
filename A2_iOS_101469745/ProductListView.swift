//
//  ProductListView.swift
//  A2_iOS_101469745
//
//  Created by Olympia Santaguida-Antunes on 2026-04-09.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
            animation: .default
        ) private var products: FetchedResults<Product>
    
    var body: some View {
        NavigationView{
            List(products) {product in
                VStack(alignment: .leading, spacing: 6){
                    Text(product.name ?? "Unknown")
                        .font(.headline)
                    
                    Text(product.productDescription ?? "No description available.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("All Products")
        }
    }
    
}
