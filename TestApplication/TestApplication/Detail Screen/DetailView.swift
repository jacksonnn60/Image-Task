//
//  DetailView.swift
//  TestApplication
//
//  Created by Jackie basss on 21.06.2021.
//

import UIKit

class DetailView: UIView {
    
    // MARK: -Variables
    
    let scrollView: UIScrollView = {
        let obj = UIScrollView()
        obj.minimumZoomScale = -5.0
        obj.maximumZoomScale = 5.0
        obj.alwaysBounceVertical = false
        obj.alwaysBounceHorizontal = false
        obj.showsVerticalScrollIndicator = true
        obj.flashScrollIndicators()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let detailImageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = false
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let cancelButton: UIButton = {
        let obj = UIButton()
        obj.tintColor = .systemGray3
        obj.setImage(UIImage(systemName: "multiply.square", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 30)), for: .normal)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Actions
    private func setup() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        scrollView.addSubview(detailImageView)
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        
        addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
