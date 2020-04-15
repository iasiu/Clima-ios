//
//  WeatherManager.swift
//  Clima
//
//  Created by Jan Lewandowski on 15/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=61bb2ab3350dfa1fc6e9491b53250ae3&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
