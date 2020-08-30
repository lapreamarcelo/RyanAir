//
//  AutocompleteTextField.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import UIKit

class AutocompleteTextField: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var placeholderLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    
    var selectStation: ((Station) -> Void)?
    
    private var placeholder: String?
    private var stations: [Station] = []
    private var filteredStations: [Station] = []
    private var hasFilter: Bool = false
    
    private var cellIdentifier = "StationTableViewCell"
    
    // MARK: - Initialization
    
    func configure(placeholder: String) {
        self.placeholder = placeholder
        
        setup()
    }
    
    func updateStations(stations: [Station]) {
        self.stations = stations
        
        tableView.reloadData()
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
        Bundle.main.loadNibNamed(String(describing: AutocompleteTextField.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layoutIfNeeded()
    }
    
    private func setup() {
        placeholderLabel.text = placeholder
        textField.placeholder = placeholder
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        hasFilter = !(textField.text?.isEmpty ?? false)
        filter(text: textField.text ?? "")
    }
    
    private func filter(text: String) {
        let filtered = stations.filter { $0.name.lowercased().contains(text.lowercased()) || $0.code.lowercased().contains(text.lowercased())}
        filteredStations = filtered
        tableView.reloadData()
    }
}

extension AutocompleteTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.isHidden = true
    }
}

extension AutocompleteTextField: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasFilter ? filteredStations.count : stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? StationTableViewCell else {
            return UITableViewCell()
        }
        
        let station = hasFilter ? filteredStations[indexPath.row] : stations[indexPath.row]
        cell.bind(station: station)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = hasFilter ? filteredStations[indexPath.row] : stations[indexPath.row]
        self.tableView.isHidden = true
        self.contentView.endEditing(true)
        self.selectStation?(station)
        self.textField.text = "\(station.name) (\(station.code))"
    }
}
