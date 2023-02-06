//
//  AboutUserController.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

class AboutUserController: CreateAccountViewController {
    
    let states = ["Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "California", "Colorado", "Connecticut", "District of Columbia", "Delaware", "Florida", "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Virginia", "Virgin Islands", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"]
    
    let role = ["Owner", "Trainer", "Behaviorist/Vet"]
    
    let label = UILabel()
    
    let nameLabel = UILabel()
    let nameField = CTextField()
    
    let emailLabel = UILabel()
    let emailField = CTextField()
    
    let phoneLabel = UILabel()
    let phoneField = CTextField()
    
    let stateLabel = UILabel()
    let stateField = CTextField()
    let statePicker = UIPickerView()
    
    let roleLabel = UILabel()
    let roleField = CTextField()
    let rolePicker = UIPickerView()
    
    let toolBar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        [label, nameLabel, nameField, emailLabel, emailField, phoneLabel, phoneField, stateLabel, stateField, roleLabel, roleField].forEach { subview in
            view.addSubview(subview)
        }
        
        view.backgroundColor = .indigo
        setUpElements()
        let backaction = UIAction{ _ in
            self.dismiss(animated: true)
        }
        let nextaction = UIAction { _ in
            
            guard let name = self.nameField.text, !name.isEmpty,
                  let email = self.emailField.text, !email.isEmpty, email.localizedCaseInsensitiveContains("@"),
                  let phone = self.phoneField.text, !phone.isEmpty,
                  let state = self.stateField.text, !state.isEmpty,
                  let role = self.roleField.text, !role.isEmpty else {
                self.presentErrorAlert(title: "Error", message: "Please complete all fields with valid inputs")
                return
            }
            let res = [name, email, phone, state, role]
            
            if role == "Owner"{
                let nextVC = UserPrefsController()
                nextVC.info = res
                nextVC.modalPresentationStyle = .fullScreen
                nextVC.modalTransitionStyle = .crossDissolve
                self.present(nextVC, animated: true)
            }else{
                let nextVC = TrainerVetController()
                nextVC.info = res
                nextVC.modalPresentationStyle = .fullScreen
                nextVC.modalTransitionStyle = .crossDissolve
                self.present(nextVC, animated: true)
            }
            
        }
        setupNextButton(action: nextaction )
        setupBackButton(action: backaction)
    }
    
    func setUpElements(){
        [nameField, emailField, phoneField, stateField, roleField].forEach { field in
            field.layer.borderWidth = textFieldBorderWidth
            field.layer.borderColor = UIColor.textFieldBorderColor
            field.layer.cornerRadius = textFieldCornerRadius
            field.backgroundColor = .white
            field.font = .systemFont(ofSize: 16)
        }
        
        [nameLabel, emailLabel, phoneLabel, stateLabel, roleLabel].forEach { label in
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.textAlignment = .left
            label.textColor = .white
        }
        
        label.text = "About You"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.text = "Name"
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).inset(-80)
            make.centerX.equalToSuperview()
            make.leading.equalTo(nameField)
        }
        
        nameField.placeholder = "Enter Full Name..."
        nameField.inputAccessoryView = toolBar
        nameField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(textFieldLeadTrail)
        }
        
        emailLabel.text = "Email"
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(nameField)
        }
        
        emailField.placeholder = "Enter Email..."
        emailField.inputAccessoryView = toolBar
        emailField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(nameField)
        }
        
        phoneLabel.text = "Phone Number"
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(nameField)
        }
        
        phoneField.placeholder = "000-000-0000"
        phoneField.keyboardType = .phonePad
        phoneField.delegate = self
        phoneField.inputAccessoryView = toolBar
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameField)
        }
        
        stateLabel.text = "State of Residence"
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(nameField)
        }
        
        stateField.delegate = self
        stateField.placeholder = "Choose State..."
        stateField.inputView = statePicker
        stateField.inputAccessoryView = toolBar
        stateField.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameField)
        }
        
        statePicker.delegate = self
        statePicker.dataSource = self
        
        roleLabel.text = "Who are you?"
        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(stateField.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(nameField)
        }
        
        roleField.delegate = self
        roleField.placeholder = "Choose Role..."
        roleField.inputView = rolePicker
        roleField.inputAccessoryView = toolBar
        roleField.snp.makeConstraints { make in
            make.top.equalTo(roleLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalTo(nameField)
        }
        
        rolePicker.delegate = self
        rolePicker.dataSource = self
        
        setUpToolBar()
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
        nameField.resignFirstResponder()
        emailField.resignFirstResponder()
        phoneField.resignFirstResponder()
        stateField.resignFirstResponder()
        roleField.resignFirstResponder()
    }
}

extension AboutUserController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePicker {
            return states[row]
        }
        else if pickerView == rolePicker{
            return role[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            stateField.text = states[row]
        } else if pickerView == rolePicker {
            roleField.text = role[row]
        }
    }
}

extension AboutUserController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return states.count
        } else if pickerView == rolePicker {
            return role.count
        }
        return 0
    }
}

extension AboutUserController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneField{
            let max = 10
            let currentString: NSString = phoneField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString

            return newString.length <= max
        }
        return false
    }
}


