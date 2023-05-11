//
//  ViewController.swift
//  Weather application
//
//  Created by Swift on 20.04.2023.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, WeatherManagerDelegate {
    func weatherManagerUpdate(_ weather: WeatherManager, weatherData: WeatherData) {
        <#code#>
    }
    
    func weatherErrorHandler(networkError: Error) {
        <#code#>
    }
    
    
    //ui elemnets
    @IBOutlet weak var myLocationButton: UIButton!
    @IBOutlet weak var seacrhTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var cordinateNameLabel: UILabel!
    @IBOutlet weak var timeZone: UILabel!
    
    var weatherManager = WeatherManager()
    // button search
    @IBAction func myLocationButtonPressed(_ sender: UIButton) {
    }
    
    // button my location
    @IBAction func searchButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
    }
    
    override func loadView() {
        super.loadView()
    }
    func textFildShouldReturn(_ textField: UITextField) -> Bool {
        seacrhTextField.endEditing(true)
        
    }

    func textFildShouldEndEditing(_ textField: UITextField) -> Bool {
        if seacrhTextField.text != "" {
            return true
        } else {
            seacrhTextField.placeholder = "пжл укажаите место"
        }
    }

    func textFildDidEndEditing(_ textField: UITextField) {
        if let text = seacrhTextField.text {
            weatherManager.featchWeather(cityName: text)
        }
        seacrhTextField.text = ""
    
    }
}

extension ViewController: WeatherManagerDelegate {
    func WeatherManagerUpdate(_ weather: WeatherManager, weatherData: WeatherData) {
        conditionImage.image =  UIImage (systemName: weatherData.conditionImages)
        degreeLabel.text = weatherData.temperature
        cityNameLabel.text = wea
    }

    func WeatherErrorHandler(networkError: Error) {
        print(networkError)
    }
}
