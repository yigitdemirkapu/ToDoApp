//
//  MainCoordinator.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    func start() {
        let todoListVC = TodoListViewController.instantiate()
        todoListVC.viewModel = TodoListViewModel()
        todoListVC.coordinator = self
        navigationController.setViewControllers([todoListVC], animated: false)
    }
    
    func goToDetailVC(with todoItem: TodoItem) {
        let todoItemDetailVC = TodoItemDetailViewController.instantiate()
        todoItemDetailVC.viewModel = TodoItemDetailViewModel(todoItem: todoItem)
        todoItemDetailVC.coordinator = self
        navigationController.pushViewController(todoItemDetailVC, animated: true)
    }
}
