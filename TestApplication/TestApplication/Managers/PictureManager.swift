//
//  PictureManager.swift
//  TestApplication
//
//  Created by Jackie basss on 19.06.2021.
//

import UIKit
import Alamofire

var imageCache = NSCache<NSString, UIImage>()
var requests = Dictionary<String, DataRequest>()

var request: DataRequest?

extension UIImageView {
     
    func loadImage(forUrl url: String,
                   progressBlock: @escaping (Float, Request.State) -> ()) {
        
        if let imageFromCache = imageCache.object(forKey: NSString(string: url)) {
            print("Get image from cache")
            
            /// Get image from cache.
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
            
        } else {
            let utilityQueue = DispatchQueue.global(qos: .utility)
            
            /// Get image from request.
            request = AF.request(url, method: .get)
                .response { data in
                    guard let image = UIImage(data: data.data!) else { return }
                    
                    imageCache.setObject(image, forKey: NSString(string: url))
                    
                    progressBlock(100, .finished)
                    
                    /// Set current progress.
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
                
                .downloadProgress(queue: utilityQueue , closure: { progress in
                    progressBlock(Float(progress.fractionCompleted), request!.state)
                })
            
            guard let request = request else {
                return
            }
            
            /// set current request to the dictionary using unique key.
            guard let id = self.id else {
                return
            }
            
            requests.updateValue(request, forKey: "\(id)")
        }
    }
}


extension UIImageView {
    
    /// Special ID to controll requests
    ///
    /// 1. Requests are saving by key: "\(UIImageView.id)"
    ///
    /// 2. After image is installed to the imageView, we clear the dictionery with request by id...
    
    struct IDHolder {
        static var id: Int?
    }
    
    var id: Int? {
        get { return IDHolder.id }
        set(newValue) { IDHolder.id = newValue }
    }
    
}
