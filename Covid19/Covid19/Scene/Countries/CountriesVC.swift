//
//  CountryViewController.swift
//  Covid19
//
//  Created by Melih Yuvacı on 1.01.2023.
//

import UIKit

class CountriesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func stopButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    

}
