//
//  FindCustomers.swift
//  RealmPOC
//
//  Created by David Tan on 1/14/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import SwiftUI

struct FindCustomers: View {
    @Binding var customers: [customer]
    @Binding var status: Status
    @Binding var name: String
    @Binding var order: String
    @Binding var city: String
    @Binding var address: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Choose City:")
                    .font(.title)
                Spacer()
                TextField("City:", text: self.$city)
                    .foregroundColor(.black)
                Spacer()
            }
            
            Spacer()
            
            Button("Find Customers", action: {
                self.customers = MongoDBRealm().getCustomers(city: self.city)
                self.status = .homepage
            })
            
            Spacer()
        }
}
}
