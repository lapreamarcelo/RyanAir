//
//  FlightResponse.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

struct FlightResponse: Codable {
    let currency: String?
    let trips: [TripResponse]?
}

extension FlightResponse {
    struct TripResponse: Codable {
        let origin: String
        let destination: String
        let dates: [FlightDatesResponse]?
        
        func convert() -> Flight.Trip {
            return Flight.Trip(origin: origin, destination: destination, dates: dates?.map { $0.convert() })
        }
    }
    
    struct FlightDatesResponse: Codable {
        let dateOut: String
        let flights: [SingleFlightResponse]
        
        func convert() -> Flight.FlightDates {
            return Flight.FlightDates(dateOut: dateOut, flights: flights.map { $0.convert() })
        }
    }
    
    struct SingleFlightResponse: Codable {
        let time: [String]
        let regularFare: RegularFareResponse
        
        func convert() -> Flight.SingleFlight {
            return Flight.SingleFlight(time: time, regularFare: regularFare.convert())
        }
    }
    
    struct RegularFareResponse: Codable {
        let fareKey: String
        let fareClass: String
        let fares: [FaresResponse]
        let businessFare: [FaresResponse]?
        let duration: String?
        let flightNumber: String?
        
        func convert() -> Flight.RegularFare {
            return Flight.RegularFare(fareKey: fareKey, fareClass: fareClass, fares: fares.map { $0.convert() }, businessFare: businessFare?.map { $0.convert() }, duration: duration, flightNumber: flightNumber)
        }
    }
    
    struct FaresResponse: Codable {
        let amount: Double
        let count: Int
        let type: String
        let hasDiscount: Bool
        let publishedFare: Double
        
        func convert() -> Flight.Fares {
            return Flight.Fares(amount: amount, count: count, type: type, hasDiscount: hasDiscount, publishedFare: publishedFare
            )
        }
    }
    
    func convert() -> Flight {
        return Flight(currency: currency, trips: trips?.map { $0.convert() })
    }
}
