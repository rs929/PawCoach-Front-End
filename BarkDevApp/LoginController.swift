//
//  LoginController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit
import SnapKit

class LoginController: UIViewController{
    
    public let textFieldBorderWidth = 1.0
    public let textFieldCornerRadius = 8.0
    public let textFieldLeadTrail = 40
    
//    let logo = UIImageView()
    let name = UILabel()
    let username = CTextField()
    let password = CTextField()
    let login = UIButton()
    let createAcc = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .indigo
        
//        logo.image = UIImage(named: "logo")
//        logo.contentMode = .scaleAspectFill
        
        name.text = "PawCoach"
        name.font = .systemFont(ofSize: 40, weight: .bold)
        name.textColor = .white
        
        username.placeholder = "Enter Username"
        username.layer.borderWidth = textFieldBorderWidth
        username.layer.borderColor = UIColor.textFieldBorderColor
        username.layer.cornerRadius = textFieldCornerRadius
        username.backgroundColor = .white
        
        password.placeholder = "Enter Password"
        password.layer.borderWidth = textFieldBorderWidth
        password.layer.borderColor = UIColor.textFieldBorderColor
        password.layer.cornerRadius = textFieldCornerRadius
        password.backgroundColor = .white
        
        login.setTitle("Login", for: .normal)
        if #available(iOS 15.0, *) {
            login.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64)
        } else {
            login.contentEdgeInsets = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 64)
        }
        login.backgroundColor = .yellow
        login.layer.cornerRadius = 10
        login.setTitleColor(.indigo, for: .normal)
        login.addTarget(self, action: #selector(logon), for: .touchUpInside)
        
        createAcc.setTitle("Create Account", for: .normal)
        createAcc.titleLabel?.font = .systemFont(ofSize: 15)
        createAcc.setTitleColor(UIColor.white, for: .normal)
        createAcc.addTarget(nil, action: #selector(createAccount), for: .touchUpInside)
        
        [name, username, password, login, createAcc].forEach { subview in
            view.addSubview(subview)
        }
        
        constrain()
        
    }
    
    func constrain(){
        name.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(150)
            make.centerX.equalToSuperview()
        }
        
//        logo.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(60)
//            make.height.width.equalTo(200)
//            make.centerX.equalToSuperview()
//        }
        
        username.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).inset(-100)
            make.leading.trailing.equalToSuperview().inset(textFieldLeadTrail)
            make.centerX.equalToSuperview()
        }
        
        password.snp.makeConstraints { make in
            make.top.equalTo(username.snp.bottom).inset(-20)
            make.leading.trailing.equalTo(username)
            make.centerX.equalToSuperview()
        }
        
        login.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).inset(-20)
            make.leading.trailing.equalTo(username).inset(80)
            make.centerX.equalToSuperview()
        }
        
        createAcc.snp.makeConstraints { make in
            make.top.equalTo(login.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func logon(){
        guard let nam = username.text, !nam.isEmpty else{
            return
        }
        NetworkManager.login(name: nam) { response in
            print(response.id)
            self.createNavBar(id: response.id, user: nam)
        }
    }
    
    @objc func createAccount(){
        let createAccountVC = AboutUserController()
        createAccountVC.modalPresentationStyle = .fullScreen
        createAccountVC.modalTransitionStyle = .crossDissolve
        navigationController?.present(createAccountVC, animated: true)
        
    }
    
    func createNavBar(id: Int, user: String) {
        let tabbar = UITabBarController()
        let vc1 = ViewController()
        vc1.user_name = user
        vc1.userID = id
        let vc2 = FilterController()
        vc2.user_name = user
        vc2.userID = id
        let vc3 = ChatController()
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Feed"
        tabbar.setViewControllers([vc1, vc2, vc3], animated: false)
        tabbar.modalPresentationStyle = .fullScreen
        tabbar.modalTransitionStyle = .crossDissolve
        
        guard let coolio = tabbar.tabBar.items else{
            return
        }
        
        let icons = ["house.fill", "magnifyingglass.circle.fill", "message.fill"]
        
        for item in 0...coolio.count-1{
            coolio[item].image = UIImage(systemName: icons[item])
        }
        tabbar.tabBar.backgroundColor = .white
        tabbar.tabBar.unselectedItemTintColor = .indigo
        tabbar.tabBar.alpha = 1
        tabbar.tabBar.layer.borderWidth = 1
        tabbar.tabBar.layer.borderColor = UIColor.black.cgColor
        self.present(tabbar, animated: true)
    }
    
}
