//
//  ViewController.swift
//  DogsPics
//
//  Created by Kishore Krishna M on 14/06/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var dogImageViewOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DogApi.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
    func handleImageFileResponse(image: UIImage? , error: Error?) {
        DispatchQueue.main.async {
            self.dogImageViewOutlet.image = image
        }
        
    }
    
    func handleRandomImageResponse(imageData: DogImages?, error: Error?) {
        guard  let imageURL = URL(string: imageData?.message ?? "" ) else {
            return
        }
        DogApi.requestImageFile(url: imageURL, completionHandler:self.handleImageFileResponse(image:error:))
        
    }
}
    
