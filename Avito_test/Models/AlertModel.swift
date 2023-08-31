//
//  AlertModel.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 30.08.2023.
//

import Foundation

struct AlertModel {
    var title : String
    var message : String
    var completion : () -> Void
}
