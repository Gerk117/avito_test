//
//  ViewController.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 27.08.2023.
//

import UIKit
import SnapKit

protocol MainScreenProtocol : AnyObject {
    func showLoadingIndicator()
    func removeLoadingIndicator()
    func showNetworkError()
    func tapOnProduct(view : UIViewController)
    func reloadCollectionOfProduct()
}
class MainScreen: UIViewController, MainScreenProtocol {
    
    
    
    var presenter : MainPresenter!
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: 185, height: 240)
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self)
        view.backgroundColor = .white
        title = "Список товаров"
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        setupView()
        setupScreen()
        presenter.load()
    }
    func reloadCollectionOfProduct() {
        collectionView.reloadData()
    }
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    func removeLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func tapOnProduct(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    func showNetworkError(){
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Невозможно получить данные",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "повторить", style: .default) { _ in
            self.presenter.load()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    private func setupView(){
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        
    }
    
    private func setupScreen() {
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension MainScreen : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.pushNextView(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell
        cell?.config(presenter.model[indexPath.row])
        return cell ?? CollectionViewCell()
        
    }
    
    
}
