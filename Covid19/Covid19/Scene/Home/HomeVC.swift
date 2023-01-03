//
//  ViewController.swift
//  Covid19
//
//  Created by Melih Yuvacı on 31.12.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func worldButtonClicked(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "WorldVC") as? WorldVC{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @IBAction func countryButtonClicked(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CountriesVC") as? CountriesVC{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

