//
//  Textfields.swift
//  SerialTime
//
//  Created by user on 23/01/2023.
//

import Foundation
import UIKit

enum Labels: String {
    case season = "Season", episode = "Episode", allSeasons = "All seasons"
}

class MyCustomTextField: UITextField, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var picker = UIPickerView()
    var type: Labels
    
    init(frame: CGRect = .zero, type: Labels) {
        self.type = type
        super.init(frame: frame)
        self.placeholder = type.rawValue
        self.borderStyle = .none
        self.font = UIFont.supplementaryItemsFont(size: 20, type: .normal)
        self.textAlignment = .center
        self.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        createToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        25
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let text = String(row)
        return text
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = String(row)
        self.text = text
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action: #selector(dissmissKeyboard))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.tintColor = .black
        self.inputAccessoryView = toolBar
    }
    
    @objc func dissmissKeyboard() {
        self.resignFirstResponder()
    }
    
}

