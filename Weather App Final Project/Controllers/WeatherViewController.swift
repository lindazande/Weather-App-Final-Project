//
//  WeatherViewController.swift
//  Weather App Final Project
//
//  Created by linda.zande on 25/08/2021.
//


import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class  WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
   

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    let weatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
 // Do any additional setup after loading the view.
    }
    #warning("infoButtonAlert")
   // @IBAction func info(_ sender: Any) {
    //    basicAlert(title: "Weather App", message: "In this app you can check weather. To change location, you can select BarButtonItem \"Arrow\" or to access Settings or Notes select BarButtonItem \"...\"!")
  //  }
    
    //MARK: -CCLocationManager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            print("Long: \(location.coordinate.longitude), lat: \(location.coordinate.latitude)")
            
            let lat = String(location.coordinate.latitude)
            let long = String(location.coordinate.longitude)
            
            let params: [String: String] = ["lat" : lat, "lon": long, "appid" : weatherDataModel.apiId]
            getWeatherData(url: weatherDataModel.apiUrl, params: params)
            
        }
        
    }
    
    func getWeatherData(url: String, params: [String: String]){
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            if  response.value != nil {
                let weatherJSON: JSON = JSON(response.value!)
                print("weatherJSON: ", weatherJSON)
                self.upadateWeatherData(json: weatherJSON)
            }else{
                self.cityLabel.text = "Weather unavailable\n 🚫!"
            }
        }
    
    }
    
    func upadateWeatherData(json: JSON){
        if let tempResult = json["main"]["temp"].double {
            weatherDataModel.temp = Int(tempResult - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            weatherDataModel.humidity = json["main"]["humidity"].intValue
    if let feelsLikeResult = json["main"]["feels_like"].double {
            weatherDataModel.feels_like = Int(feelsLikeResult - 273.15)
        weatherDataModel.speed = json["wind"]["speed"].intValue
            updateUI()
        }else{
            self.cityLabel.text = "Weather unavailable 🚫!"
        }
        }
    }
    func updateUI(){
        cityLabel.text = weatherDataModel.city
        tempLabel.text = "\(weatherDataModel.temp) ºC"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        humidityLabel.text = "Humidity \(weatherDataModel.humidity) %"
        feelsLikeLabel.text = "Feels like \(weatherDataModel.feels_like) ºC"
        windLabel.text = "Wind \(weatherDataModel.speed) km/h"
        
        
    }
    func userEnterCityName(city: String) {
        print(city)
        let params: [String: String] = ["q": city, "appid" : weatherDataModel.apiId]
        getWeatherData(url: weatherDataModel.apiUrl, params: params)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "city"{
            let vc = segue.destination as! ChangeCityViewController
            vc.delegate = self
            
        }
    else if segue.identifier == "tempConverter"{
            let vc = segue.destination as! tempConverterViewController
        
        vc.infoText = "It is \n \(weatherDataModel.temp) ºC,\n \((Double(weatherDataModel.temp) * 9 / 5) + 32) ºF,\n\(Double(weatherDataModel.temp) + 273.15) ºK\n in \(weatherDataModel.city)"
            }
    
}
}
