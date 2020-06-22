//
//  DogApi.swift
//  DogsPics
//
//  Created by Kishore Krishna M on 14/06/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit

class DogApi {
    enum EndPoint: String {
        case randomDogsFromImageCollection = "https://dog.ceo/api/breeds/image/random"
        var url : URL {
            return URL(string: self.rawValue)!
        }
    }
    
    
   class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?)-> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data,response,error)  in
            guard let data = data else {
                //else black- image will be nil
                completionHandler(nil, error)
                return
            }
            let downloagedImage = UIImage(data: data)
                //
            completionHandler(downloagedImage, nil)
        }
        task.resume()
    }
    
    class func requestRandomImage(completionHandler: @escaping (DogImages?, Error?) -> Void) {
        print(DogApi.EndPoint.randomDogsFromImageCollection.url)
        let randomImageEndPoint = DogApi.EndPoint.randomDogsFromImageCollection.url
        let task = URLSession.shared.dataTask(with: randomImageEndPoint) {(data,response,error)  in
            guard let data = data else {
                print("data is nil")
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImages.self, from: data)
            print("imageData is ")
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
}
