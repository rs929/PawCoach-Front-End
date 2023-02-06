//
//  UserPrefsController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

var sessionID: Int = 0

class UserPrefsController: CreateAccountViewController{
    
    var info: [String]?
    
    let services = ["Virtual (Through VideoChat)", "In-Person"]
    let prices = ["20", "30", "40", "50", "60", "70", "80", "90", "100"]
    
    let label = UILabel()
    
    let moneyLabel = UILabel()
    let moneyField = CTextField()
    let moneyPicker = UIPickerView()
    
    let serviceLabel = UILabel()
    let serviceField = CTextField()
    let servicePicker = UIPickerView()
    
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        let nextaction = UIAction{ _ in
            guard var money = self.moneyField.text, !money.isEmpty,
                  var service = self.serviceField.text, !service.isEmpty else{
                self.presentErrorAlert(title: "Error", message: "Please complete all fields with valid inputs")
                return
            }
            let name = self.info![0]
            let email = self.info![1]
            var phone = (self.info![2] as NSString).integerValue
            let state = self.info![3]
            let role = self.info![4]
            let mon = (money as NSString).integerValue
            
            NetworkManager.createUser(name: name, email: email, phone: phone, locale: state, prof: role, services: service, skills: "", breeds: "", price: mon) { response in
                print(response.name)
                sessionID = response.id ?? 0
            }
            
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        super.viewDidLoad()
        view.backgroundColor = .indigo
        [label, moneyLabel, moneyField, serviceLabel, serviceField].forEach { subview in
            view.addSubview(subview)
        }
        setUpElements()
        setUpToolBar()
        setupNextButton(action: nextaction)
    }
    
    func setUpElements(){
        [moneyField, serviceField].forEach { field in
            field.layer.borderWidth = textFieldBorderWidth
            field.layer.borderColor = UIColor.textFieldBorderColor
            field.layer.cornerRadius = textFieldCornerRadius
            field.backgroundColor = .white
            field.font = .systemFont(ofSize: 16)
        }
        
        [moneyLabel, serviceLabel].forEach { label in
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.textAlignment = .left
            label.textColor = .white
        }
        
        label.text = "Your Preferences"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        serviceLabel.text = "What kind of service are you looking for?"
        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).inset(-80)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(textFieldLeadTrail)
        }
        
        serviceField.placeholder = "Choose Service Type..."
        serviceField.inputAccessoryView = toolBar
        serviceField.inputView = servicePicker
        serviceField.snp.makeConstraints { make in
            make.top.equalTo(serviceLabel.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(serviceLabel)
        }
        
        moneyLabel.text = "How much would you be willing to pay?"
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(serviceLabel)
        }
        
        moneyField.placeholder = "Choose Price..."
        moneyField.inputAccessoryView = toolBar
        moneyField.inputView = moneyPicker
        moneyField.snp.makeConstraints { make in
            make.top.equalTo(moneyLabel.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(moneyLabel)
        }
        
        servicePicker.delegate = self
        servicePicker.dataSource = self
        
        moneyPicker.delegate = self
        moneyPicker.dataSource = self
    }
    
    func setUpToolBar(){
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemBlue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        let spaceButton = UIBarButtonItem(title: "                                                    ", style: .plain, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(done))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func done(){
        moneyField.resignFirstResponder()
        serviceField.resignFirstResponder()
    }
}

extension UserPrefsController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == servicePicker {
            return services[row]
        }
        else if pickerView == moneyPicker{
            return prices[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == servicePicker {
            serviceField.text = services[row]
        } else if pickerView == moneyPicker {
            moneyField.text = prices[row]
        }
    }
}

extension UserPrefsController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == servicePicker {
            return services.count
        } else if pickerView == moneyPicker {
            return prices.count
        }
        return 0
    }
}
