//
//  BreedsList.swift
//  DogsPics
//
//  Created by Kishore Krishna M on 27/06/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation

struct BreedsList: Codable {
    let status: String
    let message: [String: [String]]
}
