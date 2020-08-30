//
//  HomeViewController.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private var searchButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var originTextField: AutocompleteTextField!
    @IBOutlet private var destinationTextField: AutocompleteTextField!
    @IBOutlet private var dateTextField: UITextField!
    @IBOutlet private var adultsPickerView: PickerView!
    @IBOutlet private var teensPickerView: PickerView!
    @IBOutlet private var childrenPickerView: PickerView!
    
    var homePresenter: HomePresenter?
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let currentDate = Date()
        picker.datePickerMode = .date
        picker.backgroundColor = .white
        picker.date = currentDate
        picker.minimumDate = currentDate
        
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
        
    init(homePresenter: HomePresenter) {
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        self.homePresenter = homePresenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter?.update(view: self)
        homePresenter?.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Actions
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        homePresenter?.search()
    }
    
    @objc func doneButtonPressed() {
        view.endEditing(true)
    }
    
    @objc func dateDidChange() {
        let currentDate = datePicker.date.formatDate(with: "MM/dd/yyyy")
        dateTextField.text = currentDate
        homePresenter?.dateSelected = currentDate
    }
    
    // MARK: - Private
    
    private func setup() {
        title = "RYANAIR"
        
        searchButton.layer.cornerRadius = 5
        
        originTextField.configure(placeholder: "Origin station")
        originTextField.selectStation = { [weak self] station in
            self?.homePresenter?.originStationSelected = station
        }
        
        destinationTextField.configure(placeholder: "Destination station")
        destinationTextField.selectStation = { [weak self] station in
            self?.homePresenter?.destinationStationSelected = station
        }
        
        let currentDate = Date().formatDate(with: "MM/dd/yyyy")
        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = keyboardToolbar
        dateTextField.text = currentDate
        homePresenter?.dateSelected = currentDate
        
        adultsPickerView.configure(placeholder: "Adults", min: 1, max: 6)
        adultsPickerView.selectInput = {[weak self] input in
            self?.homePresenter?.numberOfAdults = input
        }
        
        teensPickerView.configure(placeholder: "Teens", min: 0, max: 6)
        teensPickerView.selectInput = {[weak self] input in
            self?.homePresenter?.numberOfTeens = input
        }
        
        childrenPickerView.configure(placeholder: "Children", min: 0, max: 6)
        childrenPickerView.selectInput = {[weak self] input in
            self?.homePresenter?.numberOfChildren = input
        }
    }
}

// MARK: - Extension HomeView

extension HomeViewController: HomeView {

    func startLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func stationsLoaded() {
        originTextField.updateStations(stations: homePresenter?.stations ?? [])
        destinationTextField.updateStations(stations: homePresenter?.stations ?? [])
    }
    
    func goToFlights(flight: Flight) {
        let flightsPresenter = FlightsPresenterDefault(flights: flight)
        let flightsViewController = FlightsViewController(flightPresenter: flightsPresenter)
        
        show(flightsViewController, sender: nil)
    }
}
