//
//  World.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import Foundation

struct WorldData: Codable {
    let totalConfirmed, totalDeaths: Int
    
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
    }
    
}
