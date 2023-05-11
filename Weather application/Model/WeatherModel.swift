//
//  WeatherModel.swift
//  Weather application
//
//  Created by Swift on 25.04.2023.
//

import Foundation
struct WeatherModel : Decodable {
    let coord : Coord
    let weather : [Weather]
    let main: Main
    let sys: Sys
    let timezone: Int
    let name: String
    let id: Int
}

struct Coord : Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Main: Decodable {
    let temp: Double
}

struct Sys: Decodable {
    let country: String
}
