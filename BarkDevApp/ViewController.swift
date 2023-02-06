//
//  ViewController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import UIKit
import PDFKit

let factoids = ["A dog's sense of smell is 1,000 times more powerful than a human's.",
                "Dogs can learn over 150 commands and gestures.",
                "A dog's average body temperature is 101.5°F.",
                "The average lifespan of a dog is 10-13 years.",
                "The world's smallest dog breed is the Chihuahua.",
                "The world's tallest dog breed is the Great Dane.",
                "Dogs can understand human emotions by recognizing facial expressions and body language.",
                "Dogs can see in color, but not as vividly as humans.",
                "The bond between dogs and their owners is considered to be one of the strongest in the animal kingdom.",
                "Feeding your dog a grain free diet is linked with a life-threatening heart condition."]

let articles = ["selecttrainer", "fearfuldog", "dogbit", "housetraining", "cratetraining", "separation"]

class ViewController: UIViewController {
    
    var userID: Int = 0
    var user_name: String = ""
    
    let topbar = UITextView()
    let bluebar = UILabel()
    
    let hello = UILabel()
    
    let line = UIImageView(image: UIImage(named: "line"))
    
    var indexes = 0
    
    let yourDogs = UILabel()
    
    let addDog = UIButton()
    
    let yourArticles = UILabel()
    
    var articleView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 25 //maybe change
        flowLayout.minimumInteritemSpacing = 25
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let filters = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filters.showsHorizontalScrollIndicator = false
        filters.backgroundColor = .indigo
        filters.layer.cornerRadius = 10
        return filters
    }()
    
    var dogsView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 25 //maybe change
        flowLayout.minimumInteritemSpacing = 25
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let filters = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filters.showsHorizontalScrollIndicator = false
        filters.backgroundColor = .indigo
        filters.layer.cornerRadius = 10
        return filters
    }()
    
    var dogs: [Dog] = []
    let dogID = "doggo"
    let pdfID = "hello"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [bluebar, topbar, hello, line, yourArticles, articleView, yourDogs, addDog, dogsView].forEach { subview in
            view.addSubview(subview)
        }
        setUpElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changefact()
        topbar.text = factoids[indexes]
        reload()
    }
    
    func setUpElements(){
        bluebar.backgroundColor = .indigo
        bluebar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(topbar)
        }
        topbar.backgroundColor = .indigo
        topbar.isEditable = false
        topbar.text = factoids[indexes]
        topbar.font = .systemFont(ofSize: 15, weight: .semibold)
        topbar.textAlignment = .center
        topbar.textColor = .white
        topbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        hello.text = "Hello " + user_name + "!"
        hello.font = .systemFont(ofSize: 40, weight: .bold)
        hello.snp.makeConstraints { make in
            make.top.equalTo(topbar.snp.bottom).inset(-20)
            make.leading.equalTo(dogsView)
        }
        
        line.contentMode = .scaleAspectFit
        line.backgroundColor = .white
        line.snp.makeConstraints { make in
            make.leading.equalTo(hello).inset(-20)
            make.width.equalTo(300)
            make.top.equalTo(hello.snp.bottom)
            make.height.equalTo(20)
        }
        
        yourArticles.text = "Recommended Articles:"
        yourArticles.font = .systemFont(ofSize: 25, weight: .bold)
        yourArticles.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).inset(-20)
            make.leading.equalTo(dogsView)
        }
        articleView.dataSource = self
        articleView.delegate = self
        articleView.register(PDFCell.self, forCellWithReuseIdentifier: pdfID)
        articleView.snp.makeConstraints { make in
            make.top.equalTo(yourArticles.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(yourDogs.snp.top).inset(-20)
        }

        
        yourDogs.text = "Your Dogs: "
        yourDogs.font = .systemFont(ofSize: 25, weight: .bold)
        yourDogs.snp.makeConstraints { make in
            make.leading.equalTo(dogsView)
            make.bottom.equalTo(dogsView.snp.top).inset(-8)
        }
        
        addDog.setTitle(" + Add Dog ", for: .normal)
        addDog.backgroundColor = .indigo
        addDog.setTitleColor(.yellow, for: .normal)
        addDog.titleLabel?.font = .systemFont(ofSize: 16)
        addDog.layer.cornerRadius = 10
        addDog.addTarget(self, action: #selector(doggo), for: .touchUpInside)
        addDog.snp.makeConstraints { make in
            make.top.equalTo(yourDogs)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(yourDogs)
        }
        
        dogsView.register(DogCell.self, forCellWithReuseIdentifier: dogID)
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(reload), for: .valueChanged)
        dogsView.refreshControl = refresh
        dogsView.dataSource = self
        dogsView.delegate = self
        dogsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(225)
        }
        
    }
    
    @objc func doggo(){
        let dog = DogController()
        dog.user = self.userID
        present(dog, animated: true)
    }
    
    func readPDF(pdfView: PDFView, file: String){
        let fileURL = Bundle.main.url(forResource: "Sample", withExtension: "pdf")
            pdfView.document = PDFDocument(url: fileURL!)
    }
    
    func changefact(){
        if indexes >= factoids.count - 1{
            indexes = 0
        }else{
            indexes = indexes + 1
        }
    }
    
    @objc func reload(){
        dogsView.reloadData()
        NetworkManager.getAllDogs(user_id: userID) { response in
            self.dogs = response
            self.dogsView.reloadData()
            self.dogsView.refreshControl?.endRefreshing()
            print(self.dogs)
        }
    }


}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == articleView{
            return articles.count
        } else if collectionView == dogsView{
            return dogs.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == articleView{
            if let cell = articleView.dequeueReusableCell(withReuseIdentifier: pdfID, for: indexPath) as? PDFCell{
                let art = articles[indexPath.row]
                cell.config(name: art)
                return cell
            }
            else{
                return UICollectionViewCell()
            }
        } else if collectionView == dogsView{
            if let cell = dogsView.dequeueReusableCell(withReuseIdentifier: dogID, for: indexPath) as? DogCell{
                let dog = dogs[indexPath.row]
                print("config")
                cell.config(name: dog.name, breed: dog.breed, age: dog.age, spay: dog.spay, trait: dog.trait3)
                return cell
            }
            else{
                return UICollectionViewCell()
            }
        }else{
            return UICollectionViewCell()
        }
        
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == articleView{
            if let cell = articleView.dequeueReusableCell(withReuseIdentifier: pdfID, for: indexPath) as? PDFCell{
                let art = articles[indexPath.row]
                let pdf = PDFViewer()
                pdf.config(name: art)
                present(pdf, animated: true)
            }
        }
            
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 190)
    }
}

