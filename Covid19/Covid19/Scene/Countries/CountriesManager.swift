//
//  CountriesManager.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import Foundation

protocol CountriesManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCountries(_ countriesManager: CountriesManager, countries: [CountriesModel])
}

class CountriesManager {
    
    let countriesUrl = "https://api.covid19api.com/countries"
    
    var delegate : CountriesManagerDelegate?
    var countriesArray = [CountriesModel]()
    
    func getCountries(){
        if let url = URL(string: countriesUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let countries = self.parseJson(safeData){
                        self.delegate?.didUpdateCountries(self, countries: countries)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    func parseJson(_ data: Data) -> [CountriesModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CountriesData].self, from: data)
            for each in decodedData{
                let country = each.country
                let slug = each.slug
                countriesArray.append(CountriesModel(country: country, slug: slug))
            }
            return countriesArray
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
