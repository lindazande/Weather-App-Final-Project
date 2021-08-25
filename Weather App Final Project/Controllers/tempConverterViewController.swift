//
//  tempConverterViewController.swift
//  Weather App Final Project
//
//  Created by linda.zande on 25/08/2021.
//
import UIKit

class tempConverterViewController: UIViewController {


    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var convertedTempLabel: UILabel!
    
    @IBOutlet weak var tempSegmentControl: UISegmentedControl!
    @IBOutlet weak var tempSlider: UISlider!{
        didSet{
            tempSlider.maximumValue = 100
            tempSlider.minimumValue = 0
            tempSlider.value = 0
        }
    }
    
    @IBOutlet weak var infoTextLabel: UILabel!
    var infoText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        convertedTempLabel.text = "32 ºF"
        
        if !infoText.isEmpty{
            infoTextLabel.text = infoText
            
        }
    }
    

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print("tempSlider:" , tempSlider.value)
        updateTempLabelForSlider(value: tempSlider.value)
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        updateTempLabelForSlider(value: tempSlider.value)
       
    }
    
    func updateTempLabelForSlider(value: Float){
        let celsiusTemp = Int(value)
        celsiusLabel.text = "\(celsiusTemp) ºC"
        
        var convertedTempString = ""
        switch tempSegmentControl.selectedSegmentIndex {
        case 0:
            let fahrenheitTempString = String(format: "%.2F", convertTempFrom(celsius: celsiusTemp).fahrenheit)
            convertedTempString = fahrenheitTempString + " ºF"
        default:
            let kelvinTempString = String(format: "%.2F", convertTempFrom(celsius: celsiusTemp).kelvin)
            convertedTempString = kelvinTempString + " ºK"
    }
        convertedTempLabel.text = convertedTempString
        
    }
    func convertTempFrom(celsius: Int) -> (fahrenheit: Double, kelvin: Double){
        let  fahrenheit = (Double(celsius) * 9 / 5) + 32
        let kelvin = Double(celsius) + 273.15
        return (fahrenheit, kelvin)
    }

}




