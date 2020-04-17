//
//  WeatherManager.swift
//  Clima
//
//  Created by Jan Lewandowski on 15/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=61bb2ab3350dfa1fc6e9491b53250ae3&units=metric"
    
    let weatherId = 0
    let temperature = 0.0
    let cityName = ""
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let formattedCity = cityName.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        let urlString = "\(weatherURL)&q=\(formattedCity)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // create a URL
        if let url = URL(string: urlString) {
            // create URLSession
            let session = URLSession(configuration: .default)
            
            //give the session a task
            let task = session.dataTask(with: url) { (data, responde, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let name = decodedData.name
            let countryCode = decodedData.sys.country
            
            return WeatherModel(conditionId: id, temperature: temperature, cityName: name, countryCode: countryCode)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
