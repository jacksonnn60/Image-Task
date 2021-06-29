//
//  View + Indicator.swift
//  TestApplication
//
//  Created by Jackie basss on 18.06.2021.
//

import UIKit

fileprivate var activityIndicator: UIActivityIndicatorView? = nil
extension UIView {
    
    func showIndicator() {
        activityIndicator = UIActivityIndicatorView()
        if let ai = activityIndicator {
            self.addSubview(ai)
            
            ai.translatesAutoresizingMaskIntoConstraints = false
            ai.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            ai.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            ai.startAnimating()
        }
    }
    
    func removeIndicator() {
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
            activityIndicator = nil
        }
    }
    
}
