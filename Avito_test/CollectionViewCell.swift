//
//  UIcollectionViewCell.swift
//  Avito_test
//
//  Created by Георгий Ксенодохов on 28.08.2023.
//

import UIKit
import SnapKit
class CollectionViewCell : UICollectionViewCell {
    private var nameOfProduct : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        return label
    }()
    private var price : UILabel = {
        var price = UILabel()
        price.font = UIFont.boldSystemFont(ofSize: 14)
        price.lineBreakMode = .byTruncatingTail
        price.textColor = .black
        return price
    }()
    private var location : UILabel = {
        var location = UILabel()
        location.font = UIFont.systemFont(ofSize: 12)
        location.alpha = 0.7
        location.lineBreakMode = .byTruncatingTail
        location.textColor = .black
        return location
    }()
    private var date : UILabel = {
        var date = UILabel()
        date.font = UIFont.systemFont(ofSize: 12)
        date.alpha = 0.7
        date.textColor = .black
        return date
    }()
    private var imageView : UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.layer.borderWidth = 0.5
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    func config( _ modelOfCell : ModelOfCell) {
        setupView()
        setupCell()
        nameOfProduct.text = modelOfCell.title
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let text = modelOfCell.price.components(separatedBy: " ")
        price.text = formatter.string(from:Int(text[0])! as NSNumber)! + " " + text[1]
        location.text = modelOfCell.location
        date.text = modelOfCell.date
        let urlRequest = URLRequest(url: URL(string: modelOfCell.image_url)!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    private func setupCell(){
        imageView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(price.snp_topMargin).inset(-10)
        }
        price.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalTo(nameOfProduct.snp_topMargin).inset(-10)
        }
        nameOfProduct.snp.makeConstraints { make in
            make.bottom.equalTo(location.snp_topMargin).inset(-10)
            make.left.equalToSuperview()
        }
        location.snp.makeConstraints { make in
            make.top.equalTo(nameOfProduct.snp_bottomMargin).inset(10)
            make.left.equalToSuperview()
            make.bottom.equalTo(date.snp_topMargin).inset(-10)
        }
        date.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(location.snp_bottomMargin).inset(10)
            make.bottom.equalToSuperview()
        }
        
    }
    private func setupView(){
        addSubview(date)
        addSubview(location)
        addSubview(nameOfProduct)
        addSubview(imageView)
        addSubview(price)
    }
    
}
