//
//  DogController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

public let textFieldBorderWidth = 1.0
public let textFieldCornerRadius = 8.0
public let textFieldLeadTrail = 40

class DogController: UIViewController {
    
    var user: Int = 0
    
//    let breeds = ["Australian Cattle Dog",
//                  "Australian Shepherd",
//                  "Beagle",
//                  "Belgian Malinois",
//                  "Bernese Mountain Dog",
//                  "Border Collie",
//                  "Collie",
//                  "Corgi",
//                  "Dachshund",
//                  "English Bulldog",
//                  "French Bulldog",
//                  "German Shepherd Dog",
//                  "German Shorthaired Pointer",
//                  "Golden Retriever",
//                  "Great Dane",
//                  "Labrador Retriever",
//                  "Mixed Breed",
//                  "Not Listed",
//                  "Poodle",
//                  "Rottweiler",
//                  "Siberian Husky",
//                  "Vizslas"]
    let spay = ["Neutered Male", "Intact Male", "Spayed Female", "Intact Female"]
    
    let titleLabel = UILabel()
    
    let nameLabel = UILabel()
    let nameField = CTextField()
    
    let breedLabel = UILabel()
    let breedField = CTextField()
    let breedPicker = UIPickerView()
    
    let ageLabel = UILabel()
    let ageField = CTextField()
    
    let spayLabel = UILabel()
    let spayField = CTextField()
    let spayPicker = UIPickerView()
    
    let trait1Label = UILabel()
    let trait1Field = CTextField()
    
    let trait2Label = UILabel()
    let trait2Field = CTextField()
    
    let trait3Label = UILabel()
    let trait3Field = CTextField()
    
    let button = UIButton()
    
    let toolBar = UIToolbar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .indigo
        [titleLabel, nameLabel, nameField, breedLabel, breedField, ageLabel, ageField, spayLabel, spayField, trait1Label, trait1Field, trait2Label, trait2Field, trait3Label, trait3Field, button].forEach { subview in
            view.addSubview(subview)
        }
        setUpElements()
        setUpToolBar()
    }
    
    func setUpElements(){
        titleLabel.text = "Add a Doggo"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
        
        [nameLabel, breedLabel, ageLabel, spayLabel, trait1Label, trait2Label, trait3Label].forEach { label in
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.textAlignment = .left
            label.textColor = .white
        }
        
        [nameField, breedField, ageField, spayField, trait1Field, trait2Field, trait3Field].forEach { field in
            field.layer.borderWidth = textFieldBorderWidth
            field.layer.borderColor = UIColor.textFieldBorderColor
            field.layer.cornerRadius = textFieldCornerRadius
            field.backgroundColor = .white
            field.font = .systemFont(ofSize: 16)
        }
        
        nameLabel.text = "What's your dog's name?"
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        nameField.placeholder = "Enter Dog Name..."
        nameField.inputAccessoryView = toolBar
        nameField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        breedLabel.text = "What's your dog's breed?"
        breedLabel.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).inset(-20)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        breedField.placeholder = "Choose Dog Breed..."
        breedField.inputView = breedPicker
        breedField.inputAccessoryView = toolBar
        breedField.snp.makeConstraints { make in
            make.top.equalTo(breedLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameLabel)
        }
        breedPicker.delegate = self
        breedPicker.dataSource = self
        
        ageLabel.text = "How old is your dog?"
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(breedField.snp.bottom).inset(-20)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        ageField.placeholder = "Enter Dog Age..."
        ageField.inputAccessoryView = toolBar
        ageField.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        spayLabel.text = "What is your dog's spay/neuter status?"
        spayLabel.snp.makeConstraints { make in
            make.top.equalTo(ageField.snp.bottom).inset(-20)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        spayField.placeholder = "Choose Status..."
        spayField.inputView = spayPicker
        spayField.inputAccessoryView = toolBar
        spayField.snp.makeConstraints { make in
            make.top.equalTo(spayLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameLabel)
        }
        spayPicker.delegate = self
        spayPicker.dataSource = self
        
        trait1Label.text = "Dog's Traits to Focus on:"
        trait1Label.snp.makeConstraints { make in
            make.top.equalTo(spayField.snp.bottom).inset(-30)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        trait1Field.placeholder = "Enter Trait 1..."
        trait1Field.inputAccessoryView = toolBar
        trait1Field.snp.makeConstraints { make in
            make.top.equalTo(trait1Label.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameLabel)
        }
        trait2Field.placeholder = "Enter Trait 2..."
        trait2Field.inputAccessoryView = toolBar
        trait2Field.snp.makeConstraints { make in
            make.top.equalTo(trait1Field.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameLabel)
        }
        trait3Field.placeholder = "Enter Trait 3..."
        trait3Field.inputAccessoryView = toolBar
        trait3Field.snp.makeConstraints { make in
            make.top.equalTo(trait2Field.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        button.setTitle(" Add Dog ", for: .normal)
        button.setTitleColor(.indigo, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(adddoggo), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.top.equalTo(trait3Field.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        
        
        
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
    
    @objc func adddoggo(){
        guard let name = nameField.text, !name.isEmpty,
              let breed = breedField.text, !breed.isEmpty,
              let age = ageField.text, !age.isEmpty,
              let spay = spayField.text, !spay.isEmpty,
              let trait3 = trait1Field.text, !trait3.isEmpty,
              let trait2 = trait2Field.text, !trait2.isEmpty,
              let trait1 = trait3Field.text, !trait1.isEmpty else{
            
            return
        }
        let aggy = (age as NSString).integerValue
        NetworkManager.createDoggo(user_id: user, name: name, breed: breed, age: aggy, spay: spay, trait1: trait1, trait2: trait2, trait3: trait3) { response in
            print(response.id)
        }
        dismiss(animated: true)
    }
    
    @objc func done(){
        nameField.resignFirstResponder()
        breedField.resignFirstResponder()
        ageField.resignFirstResponder()
        spayField.resignFirstResponder()
        trait1Field.resignFirstResponder()
        trait2Field.resignFirstResponder()
        trait3Field.resignFirstResponder()
    }
}

extension DogController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == breedPicker {
            return breeds[row]
        }
        else if pickerView == spayPicker{
            return spay[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == breedPicker {
            breedField.text = breeds[row]
        } else if pickerView == spayPicker {
            spayField.text = spay[row]
        }
    }
}

extension DogController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == breedPicker {
            return breeds.count
        } else if pickerView == spayPicker {
            return spay.count
        }
        return 0
    }
}


