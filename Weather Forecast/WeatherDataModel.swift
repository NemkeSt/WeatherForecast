//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Mac on 7/4/19.
//  Copyright © 2019 NemanjaStojanovic. All rights reserved.
//

import UIKit

class WeatherDataModel {

    
    
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 200...232 :
            return "tstorm3"
        
        case 300...321 :
            return "drizzle"
        
        case 500...531 :
            return "shower3"
        
        case 600...622 :
            return "snow4"
        
        case 700...781 :
            return "fog"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
    
      default:
            return "dunno"
        }

    }
}
