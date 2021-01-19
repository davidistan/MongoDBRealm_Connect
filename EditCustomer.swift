//
//  EditCustomer.swift
//  RealmPOC
//
//  Created by David Tan on 1/14/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftUI

struct EditCustomer: View {
    @Binding var customers: [customer]
    @Binding var status: Status
    @Binding var name: String
    @Binding var order: String
    @Binding var city: String
    @Binding var address: String
    @Binding var _ObjectId: ObjectId?
    
    var body: some View {
        VStack {
            Text("New Customer")
                .font(.title)
            TextField("Name", text: $name)
                .foregroundColor(.black)
            TextField("Order:", text: $order)
                .foregroundColor(.black)
            TextField("City:", text: $city)
                .foregroundColor(.black)
            TextField("Address:", text: $address)
                .foregroundColor(.black)
            Button("Confirm Changes") {
                self.updateCustomer()
                self.customers = MongoDBRealm().getCustomers(city: self.city)
                self.status = .homepage
            }
        }
    }
    
    func updateCustomer() {

        let realm = MongoDBRealm().getRealm(partitionValue: city)

        guard let customerToUpdate = realm?.object(ofType: customer.self, forPrimaryKey: _ObjectId) else {
            print("No Customer To Update")
            return
        }
        do {
            try! realm!.write {
                print("Customer To Update - \(customerToUpdate)")
                realm!.delete(customerToUpdate)
                print("Writing to Realm")
                let modifiedCustomer = customer()
                modifiedCustomer._id = _ObjectId!
                modifiedCustomer.name = name
                modifiedCustomer.order = order
                modifiedCustomer.city = city
                modifiedCustomer.address = address
                realm!.add(modifiedCustomer)
            }
        } catch {
            print("Unable to write to Realm")

        }
    }
}

