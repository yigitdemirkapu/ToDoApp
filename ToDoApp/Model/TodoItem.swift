//
//  TodoItem.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var details: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var isDeleted: Bool = false
}
