//
//  HomePresenter.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import Foundation

protocol HomeView {
    func startLoader()
    func stopLoader()
    func stationsLoaded()
    func goToFlights(flight: Flight)
}

protocol HomePresenter {
    var stations: [Station] { get }
    var originStationSelected: Station? { get set }
    var destinationStationSelected: Station? { get set }
    var dateSelected: String? { get set }
    var numberOfAdults: String { get set }
    var numberOfTeens: String { get set }
    var numberOfChildren: String { get set }
    
    func viewDidLoad()
    func update(view: HomeView)
    func search()
}

class HomePresenterDefault: HomePresenter {
    
    var stations: [Station] = []
    var dateSelected: String?
    var numberOfAdults: String = "1"
    var numberOfTeens: String = "0"
    var numberOfChildren: String = "0"
    var originStationSelected: Station?
    var destinationStationSelected: Station?
    
    private var view: HomeView?
    private var homeBusinessController: HomeBusinessController?

    // MARK: - Initialization
    
    required init(homeBusinessController: HomeBusinessController) {
        self.homeBusinessController = homeBusinessController
    }
    
    // MARK: - HomePresenter
    
    func viewDidLoad() {
        getStations()
    }
    
    func update(view: HomeView) {
        self.view = view
    }
    
    func search() {
        guard let origin = originStationSelected, let destination = destinationStationSelected, let dateSelected = dateSelected, let dateOut = Date.formatDateFromString(formatToConvert: "yyyy-MM-dd", fromFormat: "MM/dd/yyyy", stringDate: dateSelected) else {
            return
        }
        
        view?.startLoader()
        
        homeBusinessController?.getFlights(origin: origin.code, destination: destination.code, dateOut: dateOut, adults: numberOfAdults, teens: numberOfTeens, children: numberOfChildren, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.stopLoader()
                switch result {
                case .failure(let error):
                    print(error)
                    
                case .success(let flights):
                    self?.view?.goToFlights(flight: flights)
                }
            }
        })
    }
    
    // MARK: - Private
    
    private func getStations() {
        view?.startLoader()
        homeBusinessController?.getStations(completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    
                case .success(let stations):
                    self?.stations = stations
                    self?.view?.stopLoader()
                    self?.view?.stationsLoaded()
                }
            }
        })
    }
}
