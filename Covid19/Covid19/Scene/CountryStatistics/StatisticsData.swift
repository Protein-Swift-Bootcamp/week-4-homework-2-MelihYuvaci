//
//  CountryStatisticsData.swift
//  Covid19
//
//  Created by Melih Yuvacı on 3.01.2023.
//

import Foundation

struct StatisticsData: Codable {
    let id, country: String
    let confirmed, deaths, recovered, active: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case country = "Country"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
    }
}
typealias Welcome = [StatisticsData]

