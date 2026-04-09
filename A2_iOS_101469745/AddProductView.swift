//
//  AddProductView.swift
//  A2_iOS_101469745
//
//  Created by Olympia Santaguida-Antunes on 2026-04-09.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var provider: String = ""

    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Info")) {
                    TextField("Product name", text: $name)
                    TextField("Provider", text: $provider)
                }

                Section(header: Text("Description")) {
                    TextField("Describe the product...", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section(header: Text("Pricing")) {
                    HStack {
                        Text("$")
                            .foregroundColor(.secondary)
                        TextField("0.00", text: $price)
                            .keyboardType(.decimalPad)
                    }
                }

                Section {
                    Button(action: saveProduct) {
                        HStack {
                            Spacer()
                            Text("Add Product")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.accentColor)
                }
            }
            .navigationTitle("Add Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func saveProduct() {
        // input validations
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter a product name."
            showingAlert = true
            return
        }

        guard !provider.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter a provider."
            showingAlert = true
            return
        }

        guard let priceValue = Double(price), priceValue >= 0 else {
            alertMessage = "Please enter a valid price."
            showingAlert = true
            return
        }

        let newProduct = Product(context: viewContext)
        newProduct.productID = UUID()
        newProduct.name = name.trimmingCharacters(in: .whitespaces)
        newProduct.productDescription = description.trimmingCharacters(in: .whitespaces)
        newProduct.price = priceValue
        newProduct.provider = provider.trimmingCharacters(in: .whitespaces)

        do {
            try viewContext.save()
            dismiss()
        } catch {
            alertMessage = "Failed to save product. Please try again."
            showingAlert = true
        }
    }
}
