//
//  ChangeCityViewController.swift
//  Weather App Final Project
//
//  Created by linda.zande on 25/08/2021.
//

import UIKit

protocol ChangeCityDelegate {
    
    func userEnterCityName(city: String)
    
}

class ChangeCityViewController: UIViewController {
    
    var delegate: ChangeCityDelegate?
    

   
    @IBOutlet weak var cityTextField: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getWeatherTapped(_ sender: Any) {
        guard let cityName = cityTextField.text else {return }
        
        if !cityName.isEmpty {
            delegate?.userEnterCityName(city: cityName)
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }
    
    

}

