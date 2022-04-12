//
//  RealmRepository.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import Foundation
import RealmSwift

final class RealmRepository: Repository {
    let realm = try! Realm()
    
    func getAll() -> [TodoItem] {
        return realm.objects(TodoItem.self).filter("isDeleted = false").toArray(ofType: TodoItem.self)
    }
    
    func create(todoItem: TodoItem) -> Bool {
        do {
            try realm.write {
                realm.add(todoItem)
            }
            return true
        } catch {
            print("An error occured while creating TodoItem: \(error)")
            return false
        }
    }
    
    func update(todoItem: TodoItem, title: String?, details: String?, isDone: Bool?) -> Bool {
        do {
            try realm.write {
                if let title = title {
                    todoItem.title = title
                }
                if let details = details {
                    todoItem.details = details
                }
                if let isDone = isDone {
                    todoItem.isDone = isDone
                }
            }
            return true
        } catch {
            print("An error occured while updating TodoItem: \(error)")
            return false
        }
    }
    
    func delete(todoItem: TodoItem) -> Bool {
        do {
            try realm.write {
                todoItem.isDeleted = true
            }
            return true
        } catch {
            print("An error occured while deleting TodoItem: \(error)")
            return false
        }
    }
}
