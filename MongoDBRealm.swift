//
//  MongoDBRealm.swift
//  RealmPOC
//
//  Created by David Tan on 1/13/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftUI

struct MongoDBRealm {
    
    func app() -> App {
        let app = App(id: "App ID")
        return app
    }
    
    func configure(partitionValue: String) -> Realm.Configuration? {
        print("Current User - \(app())")
        print("Partition Value - \(partitionValue)")
        guard let configuration = app().currentUser?.configuration(partitionValue: partitionValue) else {
            print("Configuration Failed")
            return nil
        }
        
        return configuration
    }
    
    func getCredentials() -> Credentials {
        let credentials = Credentials.userAPIKey("API Key")
        return credentials
    }
    
    func getRealm(partitionValue: String) -> Realm? {
        var realm: Realm?
        do {
            realm = try! Realm(configuration: configure(partitionValue: partitionValue) ?? Realm.Configuration.defaultConfiguration)
        } catch {
            
        }
        
        return realm
    }
    
    func deleteCustomer(city: String, deleteCustomers: [customer]) {
        let realmCustomers = getRealm(partitionValue: city)
        
        
        do {
            try! realmCustomers!.write {
                realmCustomers!.delete(deleteCustomers)
            }
        } catch {
            
        }
    }
    
    func getCustomers(city: String = "Raleigh") -> [customer] {
        var realmCustomers: Results<customer>
        var customers = [customer]()
        realmCustomers = getRealm(partitionValue: city)!.objects(customer.self).filter("city == '\(city)'")
        for realmCustomer in realmCustomers {
            customers.append(realmCustomer)
        }
        
        return customers
}
}
