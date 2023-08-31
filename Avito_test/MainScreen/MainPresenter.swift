//
//  Presenter.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 27.08.2023.
//

import UIKit
import Alamofire

class MainPresenter {
    var model = [ModelOfCell]()
    private var network = NetworkService()
    private weak var view : MainScreenProtocol!
    
    init(view: MainScreenProtocol) {
        self.view = view
    }
    func pushNextView(index : IndexPath) {
        let screen = ProductScreen()
        screen.setupData(ProductId: model[index.row].id)
        view.tapOnProduct(view: screen)
    }
    func load(){
        DispatchQueue.main.async {
            self.view.showLoadingIndicator()
        }
        guard NetworkReachabilityManager()!.isReachable else {
            view.showNetworkError()
            return
        }
        network.downloadProductData(completion: { data in
            switch data {
            case .success(let data) :
                self.model = data
                DispatchQueue.main.async {
                    self.view.reloadCollectionOfProduct()
                    self.view.removeLoadingIndicator()
                }
            case .failure(_) :
                self.view.showNetworkError()
            }
            
        })
    }
}
