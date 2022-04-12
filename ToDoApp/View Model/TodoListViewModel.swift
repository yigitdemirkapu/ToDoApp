//
//  TodoListViewModel.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import RealmSwift

final class TodoListViewModel {
    var repository: Repository
    var todoItems: [TodoItem] = []
    
    init(repository: Repository = RealmRepository()) {
        self.repository = repository
    }
    
    func getTodoItems() {
        todoItems = repository.getAll()
    }
    
    func getTodoItem(at index: Int) -> TodoItem {
        return todoItems[index]
    }
    
    func addTodoItem(_ todoItem: TodoItem) -> Bool {
        return repository.create(todoItem: todoItem)
    }
    
    func deleteTodoItem(at index: Int) -> Bool {
        return repository.delete(todoItem: todoItems[index])
    }
}
