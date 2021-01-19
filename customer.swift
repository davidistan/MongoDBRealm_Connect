//
//  customer.swift
//  RealmPOC
//
//  Created by David Tan on 1/12/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import Foundation
import RealmSwift

class customer: Object {
    @objc dynamic var _id: ObjectId? = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var order: String? = nil
    @objc dynamic var city: String? = nil
    @objc dynamic var address: String? = nil
    override static func primaryKey() -> String? {
        return "_id"
    }
}
