//
//  UIBarButtonItem+CustomView.swift
//  carrot-home
//
//  Created by 이종원 on 6/17/25.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func generate(with config: CustomBarItemConfiguration, width: CGFloat? = nil) -> UIBarButtonItem {
        let customView = CustomBarItem(config: config)
            
        if let width = width {
            NSLayoutConstraint.activate([
                customView.widthAnchor.constraint(equalToConstant: width),
            ])
        }
        let barButtonItem = UIBarButtonItem(customView: customView)
        return barButtonItem
    }
}

