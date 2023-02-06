//
//  SubscribeController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

class SubscribeController: CreateAccountViewController {
    let button = UIButton()
    
    override func viewDidLoad() {
        view.addSubview(button)
        view.backgroundColor = .indigo
        button.setTitle("Subscribe", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(diss), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    @objc func diss(){
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
