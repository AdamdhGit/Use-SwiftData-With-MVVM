//
//  User.swift
//  PracticeSwiftDataMVVM
//
//  Created by Adam Heidmann on 7/10/24.
//

import Foundation
import SwiftData

@Model class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
