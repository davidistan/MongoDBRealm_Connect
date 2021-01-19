//
//  CustomerListView.swift
//  RealmPOC
//
//  Created by David Tan on 1/14/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import RealmSwift
import SwiftUI

struct CustomerListView: View {
    @Binding var customers: [customer]
    @Binding var status: Status
    @Binding var name: String
    @Binding var order: String
    @Binding var city: String
    @Binding var address: String
    @Binding var ObjectId: ObjectId?
    @Binding var customersToDelete: [customer]
    
    var body: some View {
        VStack {
            Text("Customers")
                .font(.title)
                .fontWeight(.bold)
            List {
                ForEach(customers, id: \.self) { customer in
                    HStack {
                        VStack {
                            Text("Name: \(customer.name!)")
                            Text("Order: \(customer.order!)")
                            Text("City: \(customer.city!)")
                            Text("Address: \(customer.address!)")
                        }.multilineTextAlignment(.leading)
                        Spacer()
                        Button("Edit Customer", action: {
                            self.name = customer.name!
                            self.order = customer.order!
                            self.city = customer.city!
                            self.address = customer.address!
                            self.ObjectId = customer._id
                            self.status = .edit
                        }).foregroundColor(.blue)
                    }
                }.onDelete(perform: deleteRow)
                
                }.onDisappear() {
                MongoDBRealm().deleteCustomer(city: self.city, deleteCustomers: self.customersToDelete)
                self.customersToDelete.removeAll()
            }
            HStack {
                Spacer()
                Button("Add Customer", action: {
                    self.status = .add
                })
                Spacer()
                Button("Find Customers", action: {
                    self.status = .find
                })
                Spacer()
            }
            Spacer()
        }
    }
    
    func deleteRow(with indexSet: IndexSet) {
        indexSet.forEach({ index in
            customersToDelete.append(customers[index])
            customers.remove(at: index)
            status = .delete
        })
    }
}

