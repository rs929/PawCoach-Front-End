//
//  ChatCell.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/5/23.
//

import Foundation
import UIKit

class ChatCell: UICollectionViewCell{
    let name = UILabel()
    let message = UILabel()
    let date = UILabel()
    let reply = UILabel()
    
    func config(name: String, message: String, date: String){
        self.name.text = name
        self.message.text = message
        self.date.text = date
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        name.font = .systemFont(ofSize: 16, weight: .semibold)
        message.font = .systemFont(ofSize: 12)
        date.font = .systemFont(ofSize: 10)
        date.textColor = .systemBlue
        reply.font = .systemFont(ofSize: 10)
        reply.textColor = .systemBlue
        reply.text = "Reply"
        addSubview(reply)
        addSubview(name)
        addSubview(message)
        addSubview(date)
        constrain()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrain(){
        name.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(name)
            make.trailing.equalToSuperview().inset(10)
        }
        reply.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        message.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(name)
        }
    }
    
}
