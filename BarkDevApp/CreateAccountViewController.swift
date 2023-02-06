//
//  CreateAccountViewController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit
import SnapKit

class CreateAccountViewController: UIViewController{
    
    public let textFieldBorderWidth = 1.0
    public let textFieldCornerRadius = 8.0
    public let textFieldLeadTrail = 40
    
    let backButton = UIButton()
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setupNextButton(action: UIAction){
        nextButton.setImage(UIImage(named: "next"), for: .normal)
        nextButton.clipsToBounds = true
        nextButton.addAction(action, for: .touchUpInside)
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            let screenSize = UIScreen.main.bounds
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(screenSize.height * 0.15)
            
        }
    }
    
    func setupBackButton(action: UIAction) {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addAction(action, for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(10)
            make.width.height.equalTo(40)
        }
    }
    
    func presentErrorAlert(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
    }
    
    
}
