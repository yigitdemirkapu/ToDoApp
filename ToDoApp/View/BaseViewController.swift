//
//  BaseViewController.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import UIKit

class BaseViewController: UIViewController {
    class var storyboard: String {
        return ""
    }
    
    func updateNavBarColor() {
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.3624901175, green: 0.2418125868, blue: 0.7386044264, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9999538064, green: 0.8206771016, blue: 0.0493510589, alpha: 1)]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9999538064, green: 0.8206771016, blue: 0.0493510589, alpha: 1)
    }
    
    func showAlert(title: String, message: String = "", confirmButtonTitle: String, cancelButtonTitle: String = "Cancel", _ confirmButtonAction: @escaping () -> ()) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: confirmButtonTitle, style: .default, handler: { (action: UIAlertAction!) in
            confirmButtonAction()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
    }
}

// MARK: Storyboarded
extension BaseViewController: Storyboarded {
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: Self.storyboard, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
