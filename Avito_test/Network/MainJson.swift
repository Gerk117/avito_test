//
//  MainJson.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 27.08.2023.
//

import Foundation

struct MainJson : Codable {
    var advertisements : [kek]
}
struct kek : Codable {
    var id : String
    var title : String
    var price : String
    var location : String
    var image_url : String
    var created_date : String
}
