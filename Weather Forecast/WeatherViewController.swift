//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Mac on 7/4/19.
//  Copyright © 2019 NemanjaStojanovic. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
   
    
    
    
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "f1ed699121010b8edde35d96b089b1ae"
    let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast"
    

    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    

    
    

    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
  
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
               // print("Succes! Got the weather data")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWatherData(json: weatherJSON)
                //print(weatherJSON)
            }
            else {
                print("Error \(response.result.error)")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    
    @IBAction func forecast(_ sender: AnyObject) {
        performSegue(withIdentifier: "toForecast", sender: self)
    }
    
  
  
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
  
    
    func updateWatherData(json: JSON) {
        if let tempResult = json["main"]["temp"].double {
            
        weatherDataModel.temperature = Int(tempResult - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
        updateUIWithWeatherData()
        } else {
            cityLabel.text = "Weather Unavalible"
        }
    
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
   
    
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lokacija = locations[locations.count - 1]
        if lokacija.horizontalAccuracy > 0 {
        locationManager.stopUpdatingLocation()
            let  longitude = String(lokacija.coordinate.longitude)
            let latitude = String(lokacija.coordinate.latitude)
                        print("longitude = \(lokacija.coordinate.longitude), latitude = \(lokacija.coordinate.latitude)")
            let params: [String:String] = ["lon" : longitude, "lat" : latitude, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
           
            
        }
        
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Location Unavalable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    func userEnteredANewCityName(city: String) {
        let params: [String:String] = ["q": city, "appid": APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    //Write the PrepareForSegue Method here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    

    
}


