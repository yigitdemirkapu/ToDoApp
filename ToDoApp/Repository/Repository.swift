//
//  Repository.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import RealmSwift

protocol Repository {
    func getAll() -> [TodoItem]
    func create( todoItem: TodoItem ) -> Bool
    func update( todoItem: TodoItem, title: String?, details: String?, isDone: Bool?) -> Bool
    func delete( todoItem: TodoItem ) -> Bool
}
