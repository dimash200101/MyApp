//
//  ToDoItem.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 08.01.2021.
//

import Foundation

public struct ToDoItem: Codable {
    var title: String
    var subtitle: String
    var deadLine: String
    var status: Status
    
    enum Status: Int, Codable {
        case inProgress = 1
        case done = 0
    }
}
