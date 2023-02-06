//
//  ChatController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

class ChatController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    let chatID = "HEHE"
    let compose = UIButton()
    let contacts: [Contact] = [Contact(name: "Trainer Mike", message: "How is Fluffy doing on her house training?", date: "02/04/23"),
                               Contact(name: "Dr. McStuffin", message: "Do you want to set up an appointment for Ollie?", date: "02/02/23"),
                               Contact(name: "Dr. Doggo", message: "How is Rufus doing on his training regimen?", date: "01/28/23"),
                               Contact(name: "Trainer Tammy", message: "Do you want to reschedule your session to next week then?", date: "01/25/23"),
                               Contact(name: "Dr. Sun", message: "Your presciption is ready for pickup", date: "01/24/23"),
                               Contact(name: "Dr. Doggo", message: "Nice to meet you, I am the Behavior Specialist for Rufus", date: "01/23/23"),
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chatView.dequeueReusableCell(withReuseIdentifier: chatID, for: indexPath) as! ChatCell
        let nam = contacts[indexPath.row].name
        let mess = contacts[indexPath.row].message
        let dat = contacts[indexPath.row].date
        
        cell.config(name: nam, message: mess, date: dat)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 100)
    }
    
    
    let chatLabel = UILabel()
    
    let line = UIImageView(image: UIImage(named: "line"))
    
    let chatView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 25 //maybe change
        flowLayout.minimumInteritemSpacing = 25
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let filters = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filters.showsHorizontalScrollIndicator = false
        filters.backgroundColor = .indigo
        return filters
    }()
    override func viewDidLoad() {
        [chatLabel, line, chatView, compose].forEach { sub in
            view.addSubview(sub)
        }
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpElements()
    }
    
    func setUpElements(){
        chatLabel.text = "Your Feed: "
        chatLabel.textAlignment = .left
        chatLabel.font = .systemFont(ofSize: 40, weight: .bold)
        chatLabel.layer.cornerRadius = 10
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(10)
        }
        
        line.contentMode = .scaleAspectFit
        line.backgroundColor = .white
        line.snp.makeConstraints { make in
            make.leading.equalTo(chatLabel).inset(-20)
            make.width.equalTo(300)
            make.top.equalTo(chatLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        chatView.layer.cornerRadius = 10
        chatView.register(ChatCell.self, forCellWithReuseIdentifier: chatID)
        chatView.dataSource = self
        chatView.delegate = self
        chatView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
        compose.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        compose.imageView?.contentMode = .scaleAspectFit
        compose.snp.makeConstraints { make in
            make.top.equalTo(chatLabel)
            make.trailing.equalTo(chatView)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
}


