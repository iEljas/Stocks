//
//  Weather Manager.swift
//  Weather application
//
//  Created by Swift on 25.04.2023.
//

import Foundation
protocol WeatherManagerDelegate {
    func weatherManagerUpdate (_ weather: WeatherManager, weatherData: WeatherData)
    func weatherErrorHandler(networkError: Error)
}
class WeatherManager {
    let baseURL: String = "https://api.openweathermap.org/data/2.5/weather?"
    let API_KEY = "b4f98a191d299a18ef1ff36aa1f80da6"
    //шаблон делегирование
    var delegate: WeatherManagerDelegate?
    
    
    //featchWeather  привязка города
    func featchWeather (cityName: String) {
        guard let url = URL (string: "\(baseURL)appid=\(API_KEY)&units=metric&=\(cityName)") else {
            return
        }
        performRequest (url: url)
    }
    //performRequest создание url task-a
    func performRequest(url: URL){
        // urlsession используется для  конвертации данных в url, тем самым преобразует в data
        let session = URLSession (configuration: .default)
        //создает task кложура для обработки data response error, если получаем данные
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                self.delegate?.weatherErrorHandler(networkError: error!)
            }
            if let data = data {
                if let weather = parseJSON(weatherData: data){
                self.delegate?.weatherManagerUpdate(self, weatherData: weather)
            }
        }
        task.resume()
    }
    //parJSON парсим данные из сети
    
    func parseJSON (weatherData: Data) -> WeatherData?{
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
            let name = decodedData.name
            let id = decodedData.weather[0].id
            let coord = ["Latitude" : decodedData.coord.lat, "Longtitude" : decodedData.coord.lon]
            let timezone = decodedData.timezone
            let temp = decodedData.main.temp
            let country = decodedData.sys.country
            let description = decodedData.weather[0].description
            
            let weather = WeatherData(name: name, temperature: temp, conditionImage: id, coord: coord , country: country, timezone: timezone)
            return weather
        } catch {
            delegate?.weatherErrorHandler(networkError: error)
            return nil
        }
    }
}
