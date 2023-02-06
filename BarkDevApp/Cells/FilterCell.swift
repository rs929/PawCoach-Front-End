//
//  FilterCell.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/5/23.
//

import Foundation
import UIKit

class FilterCell: UICollectionViewCell{
    
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
    
    let profL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let localeL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let traitsL: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    func config(name: String, prof: String, breeds: String, locale: String, traits: String){
        nameL.text = name
        profL.text = prof
        breedL.text = "Breeds: " + breeds
        localeL.text = locale
        traitsL.text = traits
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        [nameL, profL, localeL, breedL].forEach { sub in
            addSubview(sub)
        }
        constrain()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrain(){
        nameL.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        profL.snp.makeConstraints { make in
            make.top.equalTo(nameL)
            make.trailing.equalToSuperview().inset(10)
        }
        
        localeL.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom).inset(1)
            make.leading.equalTo(nameL)
        }
        
        breedL.snp.makeConstraints { make in
            make.top.equalTo(localeL.snp.bottom).inset(1)
            make.leading.equalTo(nameL)
        }
        
    }
    
}
