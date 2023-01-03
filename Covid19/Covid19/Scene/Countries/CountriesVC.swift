//
//  CountryViewController.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import UIKit

class CountriesVC: UIViewController, CountriesManagerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCountries(_ countriesManager: CountriesManager, countries: [CountriesModel]) {
        DispatchQueue.main.async {
            self.country = countries
            self.tableView.reloadData()
        }
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
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
    }
}
