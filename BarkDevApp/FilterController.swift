//
//  FilterController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

class FilterController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var userID: Int = 0
    var user_name: String = ""
    
    let filterID = "HAHA"
    let refr = UIButton()
    var matches: [User] = [User(id: 0, name: "Mike", email: "@mike", phone: "1231231234", locale: "New York", prof: "Trainer", services: "In-Person", skills: "Crate Training", breeds: "Corgi, Golden Retriever, Dachshund", price: 90),
                           User(id: 0, name: "Dr. Sun", email: "@Sun", phone: "1231231234", locale: "New York", prof: "Behaviorist/Vet", services: "In-Person", skills: "Home Training", breeds: "Husky, Golden Retriever, Corgi", price: 70),
                           User(id: 0, name: "Dr. Doggo", email: "@doggo", phone: "1231231234", locale: "New York", prof: "Behaviorist/Vet", services: "In-Person", skills: "Home Training", breeds: "Corgi, Beagle, Collie", price: 80),
                           User(id: 0, name: "Tammy", email: "@tam", phone: "1231231234", locale: "New Jersey", prof: "Trainer", services: "In-Person", skills: "Crate Training", breeds: "Poodle, French Bulldog , Corgi", price: 40)
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chatView.dequeueReusableCell(withReuseIdentifier: filterID, for: indexPath) as! FilterCell
        let nam = matches[indexPath.row].name
        let profesh = matches[indexPath.row].prof
        let breed = matches[indexPath.row].breeds
        let locale = matches[indexPath.row].locale
        let trait = ""
        
        cell.config(name: nam, prof: profesh, breeds: breed, locale: locale, traits: trait)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 150)
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
    
    override func viewDidAppear(_ animated: Bool) {
        reload()
    }
    override func viewDidLoad() {
        [chatLabel, line, chatView, refr].forEach { sub in
            view.addSubview(sub)
        }
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpElements()
    }
    
    @objc func reload(){
        chatView.reloadData()
        NetworkManager.getAllMatches(user_id: userID) { response in
            self.matches = response
            self.chatView.reloadData()
            print(self.matches)
        }
        self.chatView.refreshControl?.endRefreshing()
    }
    
    func setUpElements(){
        chatLabel.text = "Your Matches: "
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
        chatView.register(FilterCell.self, forCellWithReuseIdentifier: filterID)
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(reload), for: .valueChanged)
        chatView.refreshControl = refresh
        chatView.dataSource = self
        chatView.delegate = self
        chatView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
        refr.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        refr.imageView?.contentMode = .scaleAspectFit
        refr.snp.makeConstraints { make in
            make.top.equalTo(chatLabel)
            make.trailing.equalTo(chatView)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
}
