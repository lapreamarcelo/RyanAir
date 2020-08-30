//
//  Flight.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

struct Flight {
    let currency: String?
    let trips: [Trip]?
}

extension Flight {
    
    struct Trip {
        let origin: String
        let destination: String
        let dates: [FlightDates]?
    }
    
    struct FlightDates {
        let dateOut: String
        let flights: [SingleFlight]
    }
    
    struct SingleFlight {
        let time: [String]
        let regularFare: RegularFare
    }
    
    struct RegularFare {
        let fareKey: String
        let fareClass: String
        let fares: [Fares]
        let businessFare: [Fares]?
        let duration: String?
        let flightNumber: String?
    }
    
    struct Fares {
        let amount: Double
        let count: Int
        let type: String
        let hasDiscount: Bool
        let publishedFare: Double
    }
}
