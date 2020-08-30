//
//  MarketResponse.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

struct MarketResponse: Codable {
    let code: String
}

extension MarketResponse {
    func convert() -> Market {
        return Market(code: code)
    }
}
