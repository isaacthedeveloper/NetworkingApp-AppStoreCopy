//
//  UIImageView+DownloadImage.swift
//  NetworkingApp-AppStoreCopy
//
//  Created by Isaac Ballas on 2019-12-03.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        // After obtaining a ref to the shared `URLSession` you create a download task. this is similar to a data task, but it saved the downloaded file to a temp location on disk instead of keeping it in memory.
        let downloadTask = session.downloadTask(with: url) { [weak self] url, response, error in
            // The URL points to a local file rather than a web address.
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.image = image
                    }
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
// [weak self] is used here in the case there is no longer a UIImageView availble, so it deallocateed it instead of holding a reference to it. this way there wont be a memory leak.
