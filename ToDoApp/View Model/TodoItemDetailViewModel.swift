//
//  TodoItemDetailViewModel.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import RealmSwift

final class TodoItemDetailViewModel {
    var repository: Repository
    var todoItem: TodoItem

    init(repository: Repository = RealmRepository(), todoItem: TodoItem) {
        self.repository = repository
        self.todoItem = todoItem
    }
    
    func updateTodoItem(title: String? = nil, details: String? = nil, isDone: Bool? = nil) -> Bool {
        return repository.update(todoItem: todoItem, title: title, details: details, isDone: isDone)
    }
    
    func deleteTodoItem() -> Bool {
        return repository.delete(todoItem: todoItem)
    }
}
