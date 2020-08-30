//
//  SingleStationResponse.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

struct SingleStationResponse: Codable {
    let alternateName: String?
    let code: String
    let countryAlias: String?
    let countryCode: String
    let countryGroupCode: String
    let countryGroupName: String
    let countryName: String
    let latitude: String
    let longitude: String
    let markets: [MarketResponse]
    let mobileBoardingPass: Bool
    let name: String
    let timeZoneCode: String
}

extension SingleStationResponse {
    func convert() -> Station {
        return Station(alternateName: alternateName, code: code, countryAlias: countryAlias, countryCode: countryCode, countryGroupCode: countryGroupCode, countryGroupName: countryGroupName, countryName: countryName, latitude: latitude, longitude: longitude, markets: markets.map { $0.convert() }, mobileBoardingPass: mobileBoardingPass, name: name, timeZoneCode: timeZoneCode)
    }
}
