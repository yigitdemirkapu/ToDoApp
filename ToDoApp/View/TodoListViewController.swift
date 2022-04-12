//
//  TodoListViewController.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import UIKit

final class TodoListViewController: BaseViewController {
    // MARK - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK - Properties
    override class var storyboard: String { return K.Storyboard.main }
    var coordinator: MainCoordinator?
    var viewModel: TodoListViewModel!
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        viewModel.getTodoItems()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.subviews.forEach({$0.removeFromSuperview()})
    }
    
    // MARK - Helpers
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavigationBar() {
        title = "To-do list"
        navigationController?.navigationBar.prefersLargeTitles = true
        updateNavBarColor()
        configureRightBarButton()
    }
    
    private func configureRightBarButton() {
        let rightButton = UIButton()
        
        let plusImage = UIImage(systemName: "plus")?.resize(with: CGSize(width: 44, height: 44))?.withTintColor(#colorLiteral(red: 0.9999538064, green: 0.8206771016, blue: 0.0493510589, alpha: 1))
        rightButton.setImage(plusImage, for: .normal)
        
        rightButton.addTarget(self, action: #selector(addDidTapped), for: .touchUpInside)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(rightButton)

        let navigationBar = navigationController?.navigationBar

        let trailingContraint = NSLayoutConstraint(item: rightButton,
                                                   attribute: .trailingMargin,
                                                   relatedBy: .equal,
                                                   toItem: navigationBar,
                                                   attribute: .trailingMargin,
                                                   multiplier: 1.0,
                                                   constant: -16)
        let bottomConstraint = NSLayoutConstraint(item: rightButton,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: navigationBar,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: -6)
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
    @objc
    private func addDidTapped() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create a to-do item", message: "", preferredStyle: .alert)
        let actionCreate = UIAlertAction(title: "Create", style: .default) { [weak self] (action) in
            guard let self = self else { return }
            let todoItem = TodoItem()
            if let text = textField.text,
               text != "" {
                todoItem.title = text
                guard self.viewModel.addTodoItem(todoItem) else { return }
                self.viewModel.getTodoItems()
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Title"
            textField = alertTextField
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionCreate)
        alert.addAction(actionCancel)
        present(alert, animated: true) {
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    @objc
    private func alertControllerBackgroundTapped() {
      dismiss(animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.todoListReuseId, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        let todoItem = viewModel.getTodoItem(at: indexPath.row)
        configuration.text = todoItem.title
        cell.backgroundColor = todoItem.isDone ? .green : .white
        cell.contentConfiguration = configuration
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard viewModel.deleteTodoItem(at: indexPath.row) else { return }
            viewModel.getTodoItems()
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToDetailVC(with: viewModel.getTodoItem(at: indexPath.row))
    }
}
