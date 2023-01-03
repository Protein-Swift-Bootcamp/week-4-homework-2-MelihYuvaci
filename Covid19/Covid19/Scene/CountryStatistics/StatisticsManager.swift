//
//  CountryStatisticsManager.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import Foundation

protocol StatisticsManagerDelegate {
    func  didUpdateStatistics(_ countryStatisticsManager: StatisticsManager, statistics: [StatisticsModel])
    func didFailWithError (error: Error)
}

class StatisticsManager {

//"https://api.covid19api.com/country/south-africa?from=2021-01-02T00:00:00Z&to=2021-01-02T23:59:59Z"
    
    var statisticsArray = [StatisticsModel]()

    var delegate: StatisticsManagerDelegate?

    let countryStatisticsUrl = "https://api.covid19api.com/country"
    
    func getStatistics (countryName: String, date: String){
        let urlString = "\(countryStatisticsUrl)/\(countryName)?from=\(date)T00:00:00Z&to=\(date)T23:59:59Z"
        print(urlString)
        getStatistics(with: urlString)
    }
    
    func getStatistics(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let statistics = self.parseJson(safeData){
                        self.delegate?.didUpdateStatistics(self, statistics: statistics)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) -> [StatisticsModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([StatisticsData].self, from: data)
            for each in decodedData{
                let country = each.country
                let confirmed = each.confirmed
                let deaths = each.deaths
                let recovered = each.recovered
                let active = each.active
                statisticsArray.removeAll(keepingCapacity: false)
                statisticsArray.append(StatisticsModel(country: country, confirmed: confirmed, deaths: deaths, recovered: recovered, active: active))
            }
            return statisticsArray
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
