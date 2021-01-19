//
//  ContentView.swift
//  RealmPOC
//
//  Created by David Tan on 1/12/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import RealmSwift
import SwiftUI

struct ContentView: View {
    @State var customersToDelete: [customer] = []
    @State var status : Status = .homepage
    @State var name: String = ""
    @State var customers: [customer] = MongoDBRealm().getCustomers(city: "Raleigh")
    @State var order: String = ""
    @State var city: String = "Raleigh"
    @State var address: String = ""
    @State var ObjectId: ObjectId?
    @ViewBuilder
    var body: some View {
        if status == .homepage {
            CustomerListView(customers: self.$customers, status: self.$status, name: self.$name, order: self.$order, city: self.$city, address: self.$address, ObjectId: self.$ObjectId, customersToDelete: self.$customersToDelete)
        } else if status == .delete {
            CustomerListView(customers: self.$customers, status: self.$status, name: self.$name, order: self.$order, city: self.$city, address: self.$address, ObjectId: self.$ObjectId, customersToDelete: self.$customersToDelete)
        } else if status == .add {
            NewCustomer(customers: self.$customers, status: self.$status, name: "", order: "", city: "", address: "")
            
        } else if status == .find {
            FindCustomers(customers: self.$customers, status: self.$status, name: self.$name, order: self.$order, city: self.$city, address: self.$address)
        } else if status == .edit {
            EditCustomer(customers: self.$customers, status: self.$status, name: self.$name, order: self.$order, city: self.$city, address: self.$address, _ObjectId: self.$ObjectId)
        
        } else {
            return Text("Blank View")
        }
}
}

