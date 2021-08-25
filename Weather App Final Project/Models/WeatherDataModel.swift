//
//  WeatherDataModel.swift
//  Weather App Final Project
//
//  Created by linda.zande on 25/08/2021.
//

import Foundation

class WeatherDataModel{
    
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather"
    let apiId = "d065168e051110093ce5ad24cdd86f8a"
    
    var temp: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    //var humidity: Int = 0
    //var feels_like: Double = 0
    
    func updateWeatherIcon(condition: Int) -> String {
        switch (condition) {
        case 0...300 :
            return "storm-2"
        case 301...500 :
            return "rainy"
        case 501...600 :
            return "rainy-2"
        case 601...700 :
            return "snowy"
        case 701...771 :
            return "fog-1"
        case 772...799 :
            return "storm"
        case 800 :
            return "sunny"
        case 801...804 :
            return "cloudy"
        case 900...903, 905...1000  :
            return "storm"
        case 903 :
            return "snowflake"
        case 904 :
            return "sun"
        default :
            return "question"
        }
    }
    
}
