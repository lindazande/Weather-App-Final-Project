//
//  infoViewController.swift
//  Weather App Final Project
//
//  Created by linda.zande on 25/08/2021.
//

import UIKit

class infoViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
      
    }
    

    @IBAction func openSettings(_ sender: Any) {
        openSettings()
    }
     
    func setLabelText(){
        var text = "Unable to specify IU style"
        if self.traitCollection.userInterfaceStyle == .dark{
            text = "Dark More is ON"
        }else{
            text = "Light Mode is ON"
        }
        textLabel.text = text
    }
        func openSettings(){
            guard let settingsURL = URL(string:UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsURL){
                UIApplication.shared.open(settingsURL, options: [:]) {
                    success in
                    print("settings: ", success)
                }
            }
        }
   
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            setLabelText()
        
    }
    }
    


