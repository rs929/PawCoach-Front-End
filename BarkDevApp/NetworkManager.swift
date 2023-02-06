//
//  Network Manager.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/04/23.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "http://10.49.30.23:8000"
    
    static func createUser(name: String, email: String, phone: Int, locale: String, prof: String, services: String, skills: String, breeds: String, price: Int, completion: @escaping (User) -> Void) {
        let endpoint = "\(host)/user/"
        let params: [String : Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "locale": locale,
            "prof": prof,
            "services": services,
            "skills": skills, 
            "breeds": breeds,
            "price": price
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(User.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode createUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func login(name: String, completion: @escaping (Login) -> Void) {
        let endpoint = "\(host)/user/name"
        let params: [String : String] = [
            "user_name": name
            ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Login.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode login")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }

        
    }
    
    static func createDoggo(user_id: Int, name: String, breed: String, age: Int, spay: String, trait1: String, trait2: String, trait3: String, completion: @escaping (Dog) -> Void) {
        let endpoint = "\(host)/users/\(user_id)/dog/"
        let params: [String : Any] = [
            "name": name,
            "breed": breed,
            "age": age,
            "spay": spay,
            "trait1": trait1,
            "trait2": trait2,
            "trait3": trait3
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Dog.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode createUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getAllDogs(user_id: Int, completion: @escaping ([Dog]) -> Void) {
        let endpoint = "\(host)/users/dog/\(user_id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //Process the response
            switch (response.result) {
            case.success(let data):
                print(data)
                print("SUCCESS")
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode([Dog].self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode getAllPosts")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getAllMatches(user_id: Int, completion: @escaping ([User]) -> Void) {
        let endpoint = "\(host)/users/matches/\(user_id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //Process the response
            switch (response.result) {
            case.success(let data):
                print(data)
                print("SUCCESS")
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode([User].self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode getAllPosts")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
