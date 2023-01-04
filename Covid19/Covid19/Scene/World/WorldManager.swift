//
//  WorldManager.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import Foundation

protocol WorldManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateWorldStatics(_ worldManager: WorldManager, world: WorldModel)
}

struct WorldManager {
    
    let worldURL = "https://api.covid19api.com/world/total"
    
    var delegate : WorldManagerDelegate?
    
    //MARK: - Send Data with Protocol
    
    func getWorldStatics(){
        if let url = URL(string: worldURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let worldStatics = parseJson(safeData){
                        self.delegate?.didUpdateWorldStatics(self, world: worldStatics)
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Parse Json
    
    func parseJson(_ data: Data)-> WorldModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WorldData.self, from: data)
            let cases = decodedData.totalConfirmed
            let deaths = decodedData.totalDeaths
            let totalWorld = WorldModel(totalConfirmed: cases, totalDeaths: deaths)
            return totalWorld
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
