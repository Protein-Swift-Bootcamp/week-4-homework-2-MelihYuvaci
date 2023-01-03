//
//  CountryStatisticsViewController.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import UIKit

class StatisticsVC: UIViewController, StatisticsManagerDelegate{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    
    var countriesStatisticsManager = StatisticsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesStatisticsManager.delegate = self
        
        let today = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -1, to: today)
    }
    
    @IBAction func stopButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func datePickerClicked(_ sender: UIDatePicker) {
        
        let date = "\(sender.date)"
        let dateFirst = date.split(separator: " ")
        print(dateFirst[0])
        countriesStatisticsManager.getStatistics(countryName: "turkey", date: String(dateFirst[0]))
        
    }
    
    func didUpdateStatistics(_ countryStatisticsManager: StatisticsManager, statistics: [StatisticsModel]) {
        DispatchQueue.main.async {
            self.countryLabel.text = "Ülke: \(statistics[0].country)"
            self.confirmedLabel.text = String(statistics[0].confirmed)
            self.deathLabel.text = String(statistics[0].deaths)
            self.activeLabel.text = String(statistics[0].active)
            self.recoveredLabel.text = String(statistics[0].recovered)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
