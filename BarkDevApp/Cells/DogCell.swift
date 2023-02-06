//
//  DogCell.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

class DogCell: UICollectionViewCell {
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let nameL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let breedL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let ageL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let spayL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let traitL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    func config(name: String, breed: String, age: Int, spay: String, trait: String){
        nameL.text = "Name: " + name
        breedL.text = "Breed: " + breed
        ageL.text = "Age: " + "\(age)"
        spayL.text = "Spay: " + spay
        traitL.text = "Trait: " + trait
        image.image = UIImage(named: "dog")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        [nameL, breedL, ageL, spayL, traitL, image].forEach { sub in
            addSubview(sub)
        }
        constrain()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrain(){
        nameL.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom)
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        breedL.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom)
            make.centerX.equalToSuperview()
        }
        ageL.snp.makeConstraints { make in
            make.top.equalTo(breedL.snp.bottom)
            make.centerX.equalToSuperview()
        }
        spayL.snp.makeConstraints { make in
            make.top.equalTo(ageL.snp.bottom)
            make.centerX.equalToSuperview()
        }
        traitL.snp.makeConstraints { make in
            make.top.equalTo(spayL.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
}
