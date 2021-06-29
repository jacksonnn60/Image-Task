//
//  NasaPictureCell.swift
//  TestApplication
//
//  Created by Jackie basss on 18.06.2021.
//

import UIKit

class NasaPictureCell: UITableViewCell {
    
    // MARK: -Variables
    
    var imageURL: String? = nil
    
    var currentProgress = 0.0 {
        didSet {
            DispatchQueue.main.async {
                self.progressView.progress = Float(self.currentProgress)
            }
        }
    }
        
    let thumbnailImageView: UIImageView = {
        let obj = UIImageView()
        obj.layer.cornerRadius = 10
        obj.contentMode = .scaleToFill
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let imageNameLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.italicSystemFont(ofSize: 18)
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let dowloadButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("Dowload", for: .normal)
        obj.layer.cornerRadius = 10
        obj.backgroundColor = UIColor.customBlue
        obj.isUserInteractionEnabled = true
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let progressView: UIProgressView = {
        let obj = UIProgressView()
        obj.isHidden = true
        obj.tintColor = .lightGray
        obj.progressViewStyle = .default
        obj.setProgress(0.0, animated: false)
        obj.progressTintColor = UIColor.customBlue
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    
    // MARK: -Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    // MARK: -Actions
    
    private func setup() {
        contentView.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.4),
        ])
        
        contentView.addSubview(dowloadButton)
        NSLayoutConstraint.activate([
            dowloadButton.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor),
            dowloadButton.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 24),
            dowloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            dowloadButton.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        contentView.addSubview(imageNameLabel)
        NSLayoutConstraint.activate([
            imageNameLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
            imageNameLabel.centerXAnchor.constraint(equalTo: dowloadButton.centerXAnchor),
            imageNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imageNameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 24),
        ])
        
        
        contentView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: dowloadButton.topAnchor, constant: -10),
            progressView.centerXAnchor.constraint(equalTo: dowloadButton.centerXAnchor),
            progressView.widthAnchor.constraint(equalTo: dowloadButton.widthAnchor)
        ])
    }
    
    func setAsDownloaded() {
        self.progressView.isHidden = true
        self.dowloadButton.backgroundColor = UIColor.systemGreen
        self.dowloadButton.setTitle("Ready", for: .normal)
    }
    
    func setAsDefault() {
        self.progressView.isHidden = true
        self.dowloadButton.backgroundColor = UIColor.customBlue
        self.dowloadButton.setTitle("Dowload", for: .normal)
    }
}
