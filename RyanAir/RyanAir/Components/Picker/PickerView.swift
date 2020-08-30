//
//  Picker.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import UIKit

class PickerView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private var placeholderLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    
    var selectInput: ((String) -> Void)?
    
    private var placeholder: String?
    private var indexSelected: Int = 0
    private var min: Int = 0
    private var max: Int = 1
    private var data: [String] = []
    
    private lazy var valuePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .white
        
        return picker
    }()
    
    private lazy var keyboardToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(doneButtonPressed))
        doneButton.tintColor = .black

        toolbar.layer.shadowOffset = CGSize(width: 0, height: -3)
        toolbar.layer.shadowRadius = 2
        toolbar.layer.shadowOpacity = 0.15
        toolbar.layer.shadowColor = UIColor.darkGray.cgColor
        toolbar.barTintColor = .white
        toolbar.items = [space, doneButton]
        toolbar.sizeToFit()
        
        return toolbar
    }()
    
    // MARK: - Initialization
    
    func configure(placeholder: String?, min: Int, max: Int) {
        self.placeholder = placeholder
        self.min = min
        self.max = max
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: PickerView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layoutIfNeeded()
    }
    
    @objc func doneButtonPressed() {
        contentView.endEditing(true)
    }
    
    private func setup() {
        setupData()
        placeholderLabel.text = placeholder
        textField.inputView = valuePicker
        textField.inputAccessoryView = keyboardToolbar
    }
    
    private func setupData() {
        for index in min...max {
            data.append(String(index))
        }
        
        textField.text = data[indexSelected]
        valuePicker.reloadAllComponents()
    }
}

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: data[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = data[row]
        indexSelected = row
        selectInput?(data[row])
    }
}
