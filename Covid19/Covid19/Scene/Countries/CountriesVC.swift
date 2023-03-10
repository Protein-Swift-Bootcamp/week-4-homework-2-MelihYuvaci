//
//  CountryViewController.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import UIKit

class CountriesVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var country : [CountriesModel] = []
    var countriesManager = CountriesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        countriesManager.delegate = self
        countriesManager.getCountries()
    }
    
    @IBAction func stopButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}


//MARK: - Tableview Datasource

extension CountriesVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CountryCell
        cell.label.text = country[indexPath.row].country
        return cell
    }
}

//MARK: - Tableview Delegate Methods

extension CountriesVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "StatisticsVC") as? StatisticsVC{
            vc.route = country[indexPath.row].slug
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}
//MARK: - CountriesManagerDelegate

extension CountriesVC :CountriesManagerDelegate{
    
    func didUpdateCountries(_ countriesManager: CountriesManager, countries: [CountriesModel]) {
        DispatchQueue.main.async() {
            self.country = countries
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
   
}

//MARK: - Activity Indicator

extension CountriesVC {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}
