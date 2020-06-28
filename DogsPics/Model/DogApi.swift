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
    enum EndPoint  {
        case randomDogsFromImageCollection
        case randomImageForBreed(String)
        case listAllbreeds
        var url : URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomDogsFromImageCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllbreeds:
                 return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    
   class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?)-> Void) {
    print("requestImageFile Method")
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
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImages?, Error?) -> Void) {
        print("requestRandomImage")
        print(DogApi.EndPoint.randomDogsFromImageCollection.url)
        let randomImageEndPoint = DogApi.EndPoint.randomImageForBreed(breed).url
        print("RANDOM IMAGE ENDPOINT \(randomImageEndPoint)")
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
    
    class func requestBreedsList(completionHandler: @escaping([String], Error?) -> Void) {
        print("requestBreedsList")
        let task = URLSession.shared.dataTask(with: EndPoint.listAllbreeds.url) {(data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
            let breedsResponse = try decoder.decode(BreedsList.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
                print(breeds)
            completionHandler(breeds,nil)
            }
            catch {
                print("Error in decoding data")
            }
        }
        task.resume()
    }
}
