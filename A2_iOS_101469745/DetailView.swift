//
//  DetailView.swift
//  A2_iOS_101469745
//
//  Created by Olympia Santaguida-Antunes on 2026-04-09.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>
    
    @State private var currentIndex: Int = 0
    @State private var showingAddProduct: Bool = false
    
    var body: some View {
            NavigationView {
                VStack(spacing: 0) {

                    if products.isEmpty {
                        Spacer()
                        Text("No products found.")
                            .foregroundColor(.secondary)
                        Spacer()
                    } else {
                        let product = products[currentIndex]

                        // product card
                        VStack(alignment: .leading, spacing: 16) {
                            Text(product.name ?? "Unknown")
                                .font(.title)
                                .fontWeight(.bold)

                            Divider()

                            HStack {
                                Text("Provider")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(product.provider ?? "—")
                                    .fontWeight(.medium)
                            }

                            HStack {
                                Text("Price")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(String(format: "$%.2f", product.price))
                                    .fontWeight(.medium)
                                    .foregroundColor(.green)
                            }

                            HStack {
                                Text("ID")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(product.productID?.uuidString.prefix(8) ?? "—")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Divider()

                            Text("Description")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                            Text(product.productDescription ?? "No description available.")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
                        .padding()

                        Spacer()

                        // product counter
                        Text("\(currentIndex + 1) of \(products.count)")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                            .padding(.bottom, 8)

                        // prev/next buttons
                        HStack(spacing: 24) {
                            Button(action: {
                                if currentIndex > 0 { currentIndex -= 1 }
                            }) {
                                Label("Previous", systemImage: "chevron.left")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .disabled(currentIndex == 0)

                            Button(action: {
                                if currentIndex < products.count - 1 { currentIndex += 1 }
                            }) {
                                Label("Next", systemImage: "chevron.right")
                                    .labelStyle(.titleAndIcon)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .disabled(currentIndex == products.count - 1)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    }
                }
                .background(Color(.systemGroupedBackground))
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddProduct = true }){
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddProduct) {
                    AddProductView()
                }
                .navigationTitle("Products")
            }
        }
}

