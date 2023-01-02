//
//  Countries.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import Foundation

struct CountriesData: Codable {
    let country, slug: String

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
    }
}

