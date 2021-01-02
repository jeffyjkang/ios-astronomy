//
//  FetchPhotoOperation.swift
//  Astronomy
//
//  Created by Jeff Kang on 1/1/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {
    var marsPhotoReference: MarsPhotoReference
    var imageData: Data?
    
    var loadImage: URLSessionDataTask {
        guard let imageURL = marsPhotoReference.imageURL.usingHTTPS else { return URLSessionDataTask() }
        return URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            defer {
                self.state = .isFinished
            }
            
            if let error = error {
                print("Error in data task: \(error)")
                return
            }
            
            guard let data = data else { return }
            self.imageData = data
        }
    }
    
    init(marsPhotoReference: MarsPhotoReference) {
        self.marsPhotoReference = marsPhotoReference
    }
    
    override func start() {
        state = .isExecuting
        loadImage.resume()
    }
    
    override func cancel() {
        loadImage.cancel()
    }
}
