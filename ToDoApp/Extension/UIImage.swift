//
//  UIImage.swift
//  ToDoApp
//
//  Created by Yigit Demirkapu on 12.04.2022.
//

import UIKit

extension UIImage {
    func resize(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
