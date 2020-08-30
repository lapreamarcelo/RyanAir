//
//  StationTableViewCell.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet private var nameLabel: UILabel!

    override func prepareForReuse() {
        nameLabel.text = ""
    }
    
    func bind(station: Station) {
        separatorInset = .zero
        nameLabel.text = "\(station.name) (\(station.code))"
    }
}
