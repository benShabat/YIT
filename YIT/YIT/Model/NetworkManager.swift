//
//  NetworkManager.swift
//  YIT
//
//  Created by Ben Shabat on 18/08/2021.
//

import Foundation

final class NetworkManager {
    
    static let sharedInstance: NetworkManager = {
           let instance = NetworkManager()
           // setup code
           return instance
       }()
    
    
    func fetchData(query: String,page: String,completion: @escaping (HitsEntity) -> Void) {
            let jsonUrlString = "https://pixabay.com/api/?key=22976346-297b2975233d64b36148f6944&q=\(query)&image_type=photo&page=\(page)&per_page=40"
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let images = try JSONDecoder().decode(HitsEntity.self, from: data)
                    print(images)
                    completion(images)

                    
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
                
                            
                
            }.resume()
     
    }
}

