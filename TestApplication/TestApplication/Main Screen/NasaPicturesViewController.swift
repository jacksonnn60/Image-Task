//
//  ViewController.swift
//  TestApplication
//
//  Created by Jackie basss on 18.06.2021.
//

import UIKit
import Alamofire
// Test app:
// I took 20 pictures from the internet - nasa.com ( very heavy, over 5mb) and this small app will do some stuff with them, downloding, showing and other

class NasaPicturesViewController: UIViewController {
    
    // MARK: -Variables
    
    private let tableView = UITableView()
    private let pictureStorage = PictureStorage()
            
    // MARK: -Override
    
    override func loadView() {
        self.view = tableView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaultSetup()
    }
    
    // MARK: -Actions
    
    private func defaultSetup() {
        self.title = "Welcome to NASA"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(NasaPictureCell.self, forCellReuseIdentifier: Identifiers.NasaPictureCell.rawValue)
    }
    
    @objc func pause(_ sender: UIButton) {
        
        /// Getting current request using button tag
        ///
        /// - sender.tag == imageView.id property that we have aleready create, so by doing this we get current request for cell.
        
        let request = requests["\(sender.tag)"]
        
        if request != nil {
            
            let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0))
            
            if let pictureCell = cell as? NasaPictureCell {
                
                if request?.isSuspended == true {
                    request?.resume()
                    
                    pictureCell.dowloadButton.setTitle("Stop", for: .normal)
                    pictureCell.dowloadButton.backgroundColor = UIColor.customRed
                    
                } else {
                    request?.suspend()
                    
                    /// TODO: Set status .suspended for cell
                    
                    pictureCell.dowloadButton.setTitle("Resume", for: .normal)
                    pictureCell.dowloadButton.backgroundColor = UIColor.orange
                }
                
            }
            
        }
    }
    
    
    @objc private func downloadButtonDidTap(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath)
        
        let id = sender.tag + 0
        
        if let pictureCell = cell as? NasaPictureCell {
            
            /// Set requestID to controll needed request
            pictureCell.thumbnailImageView.id = id
            pictureCell.dowloadButton.tag = id
            
            guard let url = pictureCell.imageURL else { return }
            
            pictureCell.thumbnailImageView.showIndicator()
            
            pictureCell.thumbnailImageView.loadImage(forUrl: url) { (progress, state) in

                switch state {
                    case .finished:

                        /// Delete request from dictionary
                        requests.removeValue(forKey: "\(id)")

                        DispatchQueue.main.async { [weak self] in
                            pictureCell.thumbnailImageView.removeIndicator()
                            pictureCell.setAsDownloaded()
                            
                            /// Refreshing only needed row
                            self?.tableView.refresh(cell: sender.tag, with: .right)
//                            self?.tableView.reloadData()
                        }
                        
                    case .resumed:
                        
                        DispatchQueue.main.sync {
                            /// Removing all targets from the downloadButton
                            pictureCell.dowloadButton.removeTarget(nil, action: nil, for: .allEvents)
                            
                            /// Adding a stop target action
                            pictureCell.dowloadButton.addTarget(self, action: #selector(self.pause), for: .touchUpInside)
                        }

                        DispatchQueue.main.async {
                            pictureCell.progressView.isHidden = false
                            pictureCell.progressView.progress = progress
                        
                            pictureCell.dowloadButton.setTitle("Stop", for: .normal)
                            pictureCell.dowloadButton.backgroundColor = UIColor.customRed
                        }
                        
                    default:
                        break
                }
            }
        }
    }
}


// MARK: -TableViewDelegate + DateSource

extension NasaPicturesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(pictureStorage.picturesURLxNAME_dict).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let imageInfo = Array(pictureStorage.picturesURLxNAME_dict)[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.NasaPictureCell.rawValue, for: indexPath) as! NasaPictureCell
        
        cell.imageURL = imageInfo.key
        self.blockReusing(cell: cell)
        
        cell.imageNameLabel.text = imageInfo.value
        cell.selectionStyle = .none
                
        cell.dowloadButton.addTarget(self, action: #selector(downloadButtonDidTap(_ :)), for: .touchUpInside)
        
        cell.dowloadButton.tag = indexPath.row
                
        return cell
    }
    
    func blockReusing(cell: NasaPictureCell) {
        guard let urlString = cell.imageURL else { return }

        
        if let image = imageCache.object(forKey: NSString(string: urlString)) {

            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
                cell.setAsDownloaded()
            }

        } else {

            DispatchQueue.main.async {
                cell.thumbnailImageView.image = nil
                cell.setAsDefault()
            }

        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height * 0.32
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        guard let cell = tableView.cellForRow(at: indexPath) as? NasaPictureCell else { return }
        
        if cell.thumbnailImageView.image != nil {

            vc.modalPresentationStyle = .fullScreen
            vc.detailView.detailImageView.image = cell.thumbnailImageView.image
            
            self.navigationController?.present(vc, animated: true, completion: nil)
            
        } else {
            timeAlert(title: "Donwload the image first", message: nil, time: 0.7)
        }
    }
}

