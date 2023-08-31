//
//  OpenedScreen.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 27.08.2023.
//

import UIKit
import SnapKit

protocol ProductScreenProtocol {
    func showIndicator()
    func hideIndicator()
    func setupImage(image: UIImage)
    func config(data : ModelOfProductScreen)
    func showNetworkError()
}

class ProductScreen : UIViewController, ProductScreenProtocol {
    
    var presenter : ProductPresenter!
    
    private var stackView : UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.alignment = .top
        view.distribution = .equalCentering
        return view
    }()
    
    private var image : UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var priceLabel : UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var contanctInfo : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private var email : UILabel = {
        var label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var phone_number : UILabel = {
        var label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var descriptionProduct : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    private var location : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private var created_date : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    private var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupScreen()
        presenter.load()
    }
    
    func config(data : ModelOfProductScreen) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let text = data.price.components(separatedBy: " ")
        priceLabel.text = "Цена:\n\(formatter.string(from:Int(text[0])! as NSNumber)! + " " + text[1])"
        location.text = "Адрес:\n\(data.location)\n\(data.address)"
        created_date.text = "Дата создания:\n\(data.created_date)"
        descriptionProduct.text = "Описание:\n\(data.description)"
        contanctInfo.text = "Контактная информация:\n\(data.email)\n\(data.phone_number)"
    }
    
    func showNetworkError() {
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
    func setupImage(image : UIImage){
        self.image.image = image
    }
    
    func setupData(ProductId : String){
        presenter = ProductPresenter(view: self, productId: ProductId)
    }
    
    func showIndicator(){
        activityIndicator.startAnimating()
    }
    
    func hideIndicator(){
        activityIndicator.stopAnimating()
    }
    
    private func setupView(){
        view.addSubview(image)
        view.addSubview(stackView)
        view.addSubview(activityIndicator)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(location)
        stackView.addArrangedSubview(created_date)
        stackView.addArrangedSubview(descriptionProduct)
        stackView.addArrangedSubview(contanctInfo)
    }
    private func setupScreen(){
        image.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(image.snp_bottomMargin).inset(-15)
        }
        
        
    }
    
}

