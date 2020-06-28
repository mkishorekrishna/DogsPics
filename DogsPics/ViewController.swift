//
//  ViewController.swift
//  DogsPics
//
//  Created by Kishore Krishna M on 14/06/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewAccessibilityDelegate {
    
    
    @IBOutlet weak var dogImageViewOutlet: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var breeds : [String] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        DogApi.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        DogApi.requestBreedsList(completionHandler: handleBreedslistResponse(breeds:error:))
        
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
    
    func handleBreedslistResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
        
    }
}
    
