//
//  DetailViewController.swift
//  TestApplication
//
//  Created by Jackie basss on 21.06.2021.
//

import UIKit

// Controlle that shows the picture in original size.  Use scroll view to move on picture in DetailVC...

class DetailViewController: UIViewController {
    
    // MARK: -Variables
    
    let detailView = DetailView()
        
    // MARK: -Override
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: -Actions
    private func setup() {
        self.detailView.scrollView.delegate = self
        self.detailView.cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: -Scroll Delegate
extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailView.detailImageView
    }
}
