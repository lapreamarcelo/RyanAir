//
//  FlightTableViewCell.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    @IBOutlet private var flightNumberLabel: UILabel!
    @IBOutlet private var fligthFareLabel: UILabel!
    
    override func prepareForReuse() {
        flightNumberLabel.text = ""
        fligthFareLabel.text = ""
    }
    
    func bind(flight: Flight.SingleFlight?) {
        separatorInset = .zero
        let publishedFare = flight?.regularFare.fares.first?.publishedFare
        fligthFareLabel.text = String(publishedFare ?? 0) + " €"
    
        flightNumberLabel.text = flight?.regularFare.flightNumber ?? "RyanAir flight"
    }
    
}
