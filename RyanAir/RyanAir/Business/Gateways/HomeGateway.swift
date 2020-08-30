//
//  HomeGateway.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import Foundation

typealias StationsResponseCompletion = (Result<StationsResponse, RyanAirError>) -> Void
typealias FlightsResponseCompletion = (Result<FlightResponse, RyanAirError>) -> Void

protocol HomeGatewayProtocol {
    func getStations(completion: @escaping StationsResponseCompletion)
    func getFlights(origin: String, destination: String, dateOut: String, adults: String, teens: String, children: String, completion: @escaping FlightsResponseCompletion)
}

class HomeGateway: HomeGatewayProtocol {
    
    func getFlights(origin: String, destination: String, dateOut: String, adults: String, teens: String, children: String, completion: @escaping FlightsResponseCompletion) {
        var urlComponent = URLComponents(string: "https://sit-nativeapps.ryanair.com/api/v4/Availability")
        
        let queryItems = [URLQueryItem(name: "origin", value: origin),
                          URLQueryItem(name: "destination", value: destination),
                          URLQueryItem(name: "dateout", value: dateOut),
                          URLQueryItem(name: "adt", value: adults),
                          URLQueryItem(name: "teen", value: teens),
                          URLQueryItem(name: "chd", value: children),
                          URLQueryItem(name: "datein", value: ""),
                          URLQueryItem(name: "flexdaysbeforeout", value: "3"),
                          URLQueryItem(name: "flexdaysout", value: "3"),
                          URLQueryItem(name: "flexdaysbeforein", value: "3"),
                          URLQueryItem(name: "flexdaysin", value: "3"),
                          URLQueryItem(name: "roundtrip", value: "false"),
                          URLQueryItem(name: "ToUs", value: "AGREED")]
        
        urlComponent?.queryItems = queryItems
        
        guard let url = urlComponent?.url else {
            completion(.failure(.wrongUrl))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                completion(.failure(.unknownError))
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let flightResponse = try decoder.decode(FlightResponse.self, from: dataResponse)
                completion(.success(flightResponse))
            } catch let parsingError {
                print(parsingError)
            }
        }
        
        task.resume()
    }
    
    func getStations(completion: @escaping StationsResponseCompletion) {
        guard let url = URL(string: "https://tripstest.ryanair.com/static/stations.json") else {
            
            completion(.failure(.wrongUrl))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                completion(.failure(.unknownError))
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let stationsResponse = try decoder.decode(StationsResponse.self, from: dataResponse)
                completion(.success(stationsResponse))
            } catch let parsingError {
                print(parsingError)
            }
        }
        
        task.resume()
    }
}
