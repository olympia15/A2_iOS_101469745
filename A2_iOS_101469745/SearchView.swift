//
//  SearchView.swift
//  A2_iOS_101469745
//
//  Created by Olympia Santaguida-Antunes on 2026-04-09.
//

import SwiftUI
import CoreData

struct SearchView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var searchText: String = ""

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.name ?? "").localizedCaseInsensitiveContains(searchText) ||
                ($0.productDescription ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredProducts, id: \.productID) { product in
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.name ?? "Unknown")
                        .font(.headline)

                    Text(product.productDescription ?? "No description available.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)

                    HStack {
                        Text(product.provider ?? "—")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(String(format: "$%.2f", product.price))
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search by name or description")
            .overlay {
                if filteredProducts.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                        Text("No results for \"\(searchText)\"")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
