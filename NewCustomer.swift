//
//  NewCustomer.swift
//  RealmPOC
//
//  Created by David Tan on 1/13/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftUI

struct NewCustomer: View {
    @Binding var customers: [customer]
    @Binding var status: Status
    @State var name: String
    @State var order: String
    @State var city: String
    @State var address: String
    var body: some View {
        VStack {
            Text("New Customer")
                .font(.title)
            TextField("Name", text: $name)
                .foregroundColor(.black)
            TextField("Order:", text: $order)
                .foregroundColor(.black)
            TextField("City", text: $city)
                .foregroundColor(.black)
            TextField("Address:", text: $address)
                .foregroundColor(.black)
            Button("Create New Customer") {
                var newCustomer = customer()
                newCustomer._id = ObjectId.generate()
                newCustomer.name = self.name
                newCustomer.order = self.order
                newCustomer.city = self.city
                newCustomer.address = self.address
                self.customers.append(newCustomer)
                self.status = .homepage
            }
//            }
//        }
        }.onDisappear() {
            self.createNewCustomer()
        }
    }
    
    func createNewCustomer() {
        print("Create New Customer")
        let realm = MongoDBRealm().getRealm(partitionValue: city)
        let newCustomer = customer()
        do {
            try! realm!.write {
                print("Writing to Realm")
                newCustomer._id = ObjectId.generate()
                newCustomer.name = name
                newCustomer.order = order
                newCustomer.city = city
                newCustomer.address = address
                realm!.add(newCustomer)
            }
        } catch {
            print("Unable to write to Realm")

        }
    }
}
