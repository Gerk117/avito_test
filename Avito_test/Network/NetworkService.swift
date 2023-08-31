//
//  NetworkService.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 29.08.2023.
//

import Foundation
import Alamofire
class NetworkService {
    
    func downloadProductData(completion: @escaping (Result<[ModelOfCell],Error>) -> Void) {
        let urlReq = URLRequest(url: URL(string: "https://www.avito.st/s/interns-ios/main-page.json")!)
        var models = [ModelOfCell]()
        URLSession.shared.dataTask(with: urlReq) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }
            if let data = data {
                let decoder = try! JSONDecoder().decode(MainJson.self, from: data)
                for data in decoder.advertisements {
                    let model = ModelOfCell(id: data.id, image_url: data.image_url, title: data.title, price: data.price, location: data.location, date: data.created_date)
                    models.append(model)
                }
                completion(.success(models))
            }
        }.resume()
    }
    
    func downloadProductInfo(id : String , completion: @escaping (Result<ModelOfProductScreen,Error>) -> Void) {
        let urlReq = URLRequest(url: URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")!)
        URLSession.shared.dataTask(with: urlReq) { data, _, error in
            if let error {
                completion(.failure(error))
            }
            if let data = data {
                let decoder = try! JSONDecoder().decode(ProductJson.self, from: data)
                var model = ModelOfProductScreen(id: decoder.id,
                                                 title: decoder.title,
                                                 price: decoder.price,
                                                 location: decoder.location,
                                                 image_url: decoder.image_url,
                                                 created_date: decoder.created_date,
                                                 description: decoder.description,
                                                 email: decoder.email,
                                                 phone_number: decoder.phone_number,
                                                 address: decoder.address)
                completion(.success(model))
            }
        }.resume()
    }
    
    static func loadImageByUrl(stringURL : String, completion : @escaping (Data)->Void) {
        let urlReq = URLRequest(url: URL(string: stringURL)!)
        URLSession.shared.dataTask(with: urlReq) { data, _, _ in
            if let data {
                completion(data)
            }
        }.resume()
    }
    
}
