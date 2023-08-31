//
//  ProductPresenter.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 30.08.2023.
//

import UIKit
import Alamofire

class ProductPresenter {
    private var network = NetworkService()
    private var view : ProductScreenProtocol!
    private var model : ModelOfProductScreen!
    var productId : String
    
    init(view: ProductScreenProtocol, productId : String) {
        self.view = view
        self.productId = productId
    }
    func load() {
        view.showIndicator()
        guard NetworkReachabilityManager()!.isReachable else {
            view.showNetworkError()
            return
        }
        network.downloadProductInfo(id: productId) { data in
            switch data {
            case let .success(model) :
                self.model = model
                NetworkService.loadImageByUrl(stringURL: model.image_url) { data in
                    DispatchQueue.main.async {
                        self.view.setupImage(image: UIImage(data: data)!)
                        self.view.config(data: model)
                        self.view.hideIndicator()
                    }
                }
            case  .failure(_) :
                self.view.showNetworkError()
            }
        }
    }
}
