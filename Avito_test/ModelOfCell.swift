//
//  ModelOfCell.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 28.08.2023.
//

import UIKit
struct ModelOfCell {
    var id : String
    var image_url : String
    var title : String
    var price : String
    var location : String
    var date : String
    init(id : String, image_url: String, title: String, price: String, location: String, date: String) {
        self.id = id
        self.image_url = image_url
        self.title = title
        self.price = price
        self.location = location
        self.date = date
    }
}

