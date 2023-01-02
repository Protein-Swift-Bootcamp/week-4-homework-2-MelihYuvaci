//
//  WorldViewController.swift
//  Covid19
//
//  Created by Melih Yuvacı on 31.12.2022.
//

import UIKit

class WorldVC: UIViewController {

    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var totalDeathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    @IBAction func stopButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
