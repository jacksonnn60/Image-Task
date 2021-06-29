//
//  View + Alert.swift
//  TestApplication
//
//  Created by Jackie basss on 21.06.2021.
//

import UIKit

extension UIViewController {
    
    func timeAlert(title: String, message: String?, time: Double) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
        })
    }
    
}
