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
    
    var worldManager = WorldManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        worldManager.delegate = self
        worldManager.getWorldStatics()
        
    }
    @IBAction func stopButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}

//MARK: - WorldManagerDelegate

extension WorldVC : WorldManagerDelegate{
    func didUpdateWorldStatics(_ worldManager: WorldManager, world: WorldModel) {
        DispatchQueue.main.async {
            self.totalCaseLabel.text = String(world.totalConfirmed)
            self.totalDeathLabel.text = String(world.totalDeaths)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
