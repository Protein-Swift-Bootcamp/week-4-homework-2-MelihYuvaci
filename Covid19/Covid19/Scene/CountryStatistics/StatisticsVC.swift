//
//  CountryStatisticsViewController.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import UIKit

class StatisticsVC: UIViewController{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var countriesStatisticsManager = StatisticsManager()
    var route : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesStatisticsManager.delegate = self
        
        let today = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -2, to: today)
        loadStatistics()
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    
    @IBAction func stopButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    //MARK: - Date Picker
    
    @IBAction func datePickerClicked(_ sender: UIDatePicker) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
           
        }
        loadStatistics()
        
    }
    
}



//MARK: - StaticsManagerDelegate

extension StatisticsVC: StatisticsManagerDelegate{
    
    func didUpdateStatistics(_ countryStatisticsManager: StatisticsManager, statistics: [StatisticsModel]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.countryLabel.text = String(statistics[0].country)
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

//MARK: - Data Manipulation Method

extension StatisticsVC{
    
    func loadStatistics(){
        
        let date = "\(datePicker.date)"
        let dateFirst = date.split(separator: " ")
        print(dateFirst[0])
        if route != "" {
            print(route!)
            countriesStatisticsManager.getStatistics(countryName: route!, date: String(dateFirst[0]))
        }
    }
}

//MARK: - Activity Indicator

extension StatisticsVC {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

}
