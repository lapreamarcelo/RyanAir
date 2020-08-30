//
//  FlightTableViewCell.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    @IBOutlet private var flightLabel: UILabel!
    @IBOutlet private var flightNumberLabel: UILabel!
    @IBOutlet private var fligthFareLabel: UILabel!
    @IBOutlet private var flightDate: UILabel!
    
    override func prepareForReuse() {
        flightNumberLabel.text = ""
        fligthFareLabel.text = ""
        flightLabel.text = ""
        flightDate.text = ""
    }
    
    func bind(origin: String?, destination: String?, singleFlight: Flight.SingleFlight?) {
        separatorInset = .zero
        let publishedFare = singleFlight?.regularFare.fares.first?.publishedFare
        fligthFareLabel.text = String(publishedFare ?? 0) + " €"
    
        flightNumberLabel.text = singleFlight?.regularFare.flightNumber ?? "Flight number"
        
        flightLabel.text = "\(origin ?? "") - \(destination ?? "")"
        
        let departure = Date.formatDateFromString(formatToConvert: "HH:mm:ss", fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", stringDate: singleFlight?.time[0] ?? "")
        
        let arrival = Date.formatDateFromString(formatToConvert: "HH:mm:ss", fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", stringDate: singleFlight?.time[1] ?? "")
        
        flightDate.text = "\(departure ?? "") - \(arrival ?? "")"
    }
    
}
