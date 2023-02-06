//
//  User.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/5/23.
//

import Foundation
import UIKit

struct User: Codable{
    let id: Int?
    let name: String
    let email: String
    let phone: String
    let locale: String
    let prof: String
    let services: String
    let skills: String
    let breeds: String
    let price: Int
}

struct Login: Codable{
    let id: Int
}
