//
//  FlightsPresenter.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import Foundation

protocol FlightsView {
}

protocol FlightsPresenter {
    var flights: Flight? { get }
    
    func viewDidLoad()
    func update(view: FlightsView)
}

class FlightsPresenterDefault: FlightsPresenter {
    
    var flights: Flight?

    private var view: FlightsView?

    // MARK: - Initialization
    
    required init(flights: Flight) {
        self.flights = flights
    }
    
    // MARK: - AlbumPresenter
    
    func viewDidLoad() {
        
    }
    
    func update(view: FlightsView) {
        self.view = view
    }
    
    // MARK: - Private

}

