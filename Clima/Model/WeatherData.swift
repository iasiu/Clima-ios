//
//  WeatherData.swift
//  Clima
//
//  Created by Jan Lewandowski on 16/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let sys: SysInfo
    let name: String
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    let feels_like : Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct SysInfo: Codable {
    let country: String
}

    


