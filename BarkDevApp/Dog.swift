//
//  Dog.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

struct Dog: Codable{
    let id: Int?
    let name: String
    let breed: String
    let age: Int
    let spay: String
    let trait1: String?
    let trait2: String?
    let trait3: String
}
