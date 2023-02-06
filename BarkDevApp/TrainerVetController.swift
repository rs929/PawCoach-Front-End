//
//  TrainerVetController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit
import UIMultiPicker

let services = ["Virtual (Through VideoChat)", "In-Person"]
let prices = ["20", "30", "40", "50", "60", "70", "80", "90", "100"]
let breeds = ["Australian Cattle Dog",
              "Australian Shepherd",
              "Beagle",
              "Belgian Malinois",
              "Bernese Mountain Dog",
              "Border Collie",
              "Collie",
              "Corgi",
              "Dachshund",
              "English Bulldog",
              "French Bulldog",
              "German Shepherd Dog",
              "German Shorthaired Pointer",
              "Golden Retriever",
              "Great Dane",
              "Labrador Retriever",
              "Mixed Breed",
              "Not Listed",
              "Poodle",
              "Rottweiler",
              "Siberian Husky",
              "Vizslas"]
var selected = [Int]()

class TrainerVetController: CreateAccountViewController {
    
    var info: [String]?
    
    let label = UILabel()

    let serviceLabel = UILabel()
    let serviceField = CTextField()
    let servicePicker = UIPickerView()

    let skillsLabel = UILabel()
    let skillsField = UITextView()

    let breedsLabel = UILabel()
    let breedsField = CTextField()
    let breedsPicker = UIPickerView()

    let moneyLabel = UILabel()
    let moneyField = CTextField()
    let moneyPicker = UIPickerView()

    let toolBar = UIToolbar()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        [label, moneyLabel, moneyField, serviceLabel, serviceField, skillsLabel, skillsField, breedsLabel, breedsField].forEach { subview in
            view.addSubview(subview)
            view.backgroundColor = .indigo
        }
        
        let nextaction = UIAction {_ in
            guard let money = self.moneyField.text, !money.isEmpty,
                  let service = self.serviceField.text, !service.isEmpty,
                  let skills = self.skillsField.text, !skills.isEmpty,
                  let breeds = self.breedsField.text, !breeds.isEmpty else{
                self.presentErrorAlert(title: "Error", message: "Please complete all fields with valid inputs")
                return
            }
            
            let name = self.info![0]
            let email = self.info![1]
            var phone = (self.info![2] as NSString).integerValue
            let state = self.info![3]
            let role = self.info![4]
            let mon = (money as NSString).integerValue
            
            NetworkManager.createUser(name: name, email: email, phone: phone, locale: state, prof: role, services: service, skills: skills, breeds: breeds, price: mon) { response in
                    print(response.name)
                    sessionID = response.id ?? 0
            }
            let nextVC = SubscribeController()
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .crossDissolve
            self.present(nextVC, animated: true)
            
        }
        setUpElements()
        setUpToolBar()
        setupNextButton(action: nextaction)
    }
    
    func setUpElements(){
        [moneyField, serviceField, breedsField].forEach { field in
            field.layer.borderWidth = textFieldBorderWidth
            field.layer.borderColor = UIColor.textFieldBorderColor
            field.layer.cornerRadius = textFieldCornerRadius
            field.backgroundColor = .white
            field.font = .systemFont(ofSize: 16)
        }
        
        [moneyLabel, serviceLabel, skillsLabel, breedsLabel].forEach { label in
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
        
        serviceLabel.text = "What type of service are you offering?"
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
        
        skillsLabel.text = "Free Space:"
        skillsLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(textFieldLeadTrail)
        }
        
        skillsField.text = "Use this space to detail some of the services you offer as well as pricing and packages"
        skillsField.inputAccessoryView = toolBar
        skillsField.layer.borderWidth = textFieldBorderWidth
        skillsField.layer.borderColor = UIColor.textFieldBorderColor
        skillsField.layer.cornerRadius = textFieldCornerRadius
        skillsField.backgroundColor = .white
        skillsField.font = .systemFont(ofSize: 16)
        
        skillsField.snp.makeConstraints { make in
            make.top.equalTo(skillsLabel.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(serviceLabel)
            make.height.equalTo(100)
        }
        
        
        breedsLabel.text = "Which dog breeds do you specialize in?"
        breedsLabel.snp.makeConstraints { make in
            make.top.equalTo(skillsField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(serviceLabel)
        }
        
        breedsField.placeholder = "Choose Price..."
        breedsField.inputAccessoryView = toolBar
        breedsField.inputView = breedsPicker
        breedsField.snp.makeConstraints { make in
            make.top.equalTo(breedsLabel.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(serviceLabel)
        }
        
        moneyLabel.text = "How much would you charge?"
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(breedsField.snp.bottom).inset(-20)
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
        
        breedsPicker.dataSource = self
        breedsPicker.delegate = self
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
        skillsField.resignFirstResponder()
        breedsField.resignFirstResponder()
    }
}

extension TrainerVetController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == servicePicker {
            return services[row]
        }
        else if pickerView == moneyPicker{
            return prices[row]
        } else if pickerView == breedsPicker{
            return breeds[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == servicePicker {
            serviceField.text = services[row]
        } else if pickerView == moneyPicker {
            moneyField.text = prices[row]
        } else if pickerView == breedsPicker{
            breedsField.text = (breedsField.text ?? "") + breeds[row] + ", "
        }
    }
}

extension TrainerVetController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == servicePicker {
            return services.count
        } else if pickerView == moneyPicker {
            return prices.count
        } else if pickerView == breedsPicker {
            return breeds.count
        }
        return 0
    }
}

