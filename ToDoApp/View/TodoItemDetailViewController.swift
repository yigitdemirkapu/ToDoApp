//
//  TodoItemDetailViewController.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import UIKit

final class TodoItemDetailViewController: BaseViewController {
    // MARK - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle("Save", for: .normal)
        }
    }
    @IBOutlet weak var finalizeButton: UIButton! {
        didSet {
            finalizeButton.setTitle("Finalize", for: .normal)
        }
    }
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.setTitle("Delete", for: .normal)
        }
    }
    // MARK - Properties
    override class var storyboard: String { return K.Storyboard.main }
    var coordinator: MainCoordinator?
    var viewModel: TodoItemDetailViewModel!

    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        detailsTextView.layer.cornerRadius = 10
    }
    
    // MARK - Helpers
    private func configureUI() {
        configureNavigationBar()
        titleTextField.text = viewModel.todoItem.title
        detailsTextView.text = viewModel.todoItem.details
    }
    
    private func configureNavigationBar() {
        title = viewModel.todoItem.title
        navigationController?.navigationBar.prefersLargeTitles = true
        updateNavBarColor()
    }
    
    // MARK - IBActions
    @IBAction func saveButton(_ sender: Any) {
        guard viewModel.updateTodoItem(title: titleTextField.text, details: detailsTextView.text) else { return }
        title = titleTextField.text
    }
    @IBAction func finalizeButton(_ sender: Any) {
        showAlert(title: "Are you sure you want to finalize this task?", confirmButtonTitle: "Yes, finalize it") {
            guard self.viewModel.updateTodoItem(isDone: true) else { return }
            self.coordinator?.navigationController.popViewController(animated: true)
        }
    }
    @IBAction func deleteButton(_ sender: Any) {
        showAlert(title: "Are you sure you want to delete this task?", confirmButtonTitle: "Yes, delete it") {
            guard self.viewModel.deleteTodoItem() else { return }
            self.coordinator?.navigationController.popViewController(animated: true)
        }
    }
}
