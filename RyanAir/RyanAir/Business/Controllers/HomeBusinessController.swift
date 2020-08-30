//
//  HomeBusinessController.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

typealias StationsCompletion = (Result<[Station], RyanAirError>) -> Void
typealias FlightsCompletion = (Result<Flight, RyanAirError>) -> Void

class HomeBusinessController {
    
    var homeGateway: HomeGatewayProtocol
    
    init(homeGateway: HomeGatewayProtocol) {
        self.homeGateway = homeGateway
    }
    
    func getFlights(origin: String, destination: String, dateOut: String, adults: String, teens: String, children: String, completion: @escaping FlightsCompletion) {
        homeGateway.getFlights(origin: origin, destination: destination, dateOut: dateOut, adults: adults, teens: teens, children: children) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let flightResponse):
                completion(.success(flightResponse.convert()))
            }
        }
    }
    
    func getStations(completion: @escaping StationsCompletion) {
        homeGateway.getStations { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let stationsResponse):
                completion(.success(stationsResponse.stations.map { $0.convert() }))
            }
        }
    }
}
