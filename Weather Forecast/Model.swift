//
//  Model.swift
//  Weather Forecast
//
//  Created by Mac on 7/5/19.
//  Copyright © 2019 NemanjaStojanovic. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class getForcast {
 
    func getForecast(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                // print("Succes! Got the weather data forecast")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWatherData(json: weatherJSON)
                
                
                
                // print(weatherJSON)
                
            }
            else {
                print("Error \(response.result.error)")
                
                
            }
            
        }
        
    }
    
    
    


func updateWatherData(json:JSON) {
    
    
    
    
    
    
    let tMax1 = Double(json["list"][8]["main"]["temp_max"].stringValue)!
    let tMax2 = Double(json["list"][16]["main"]["temp_max"].stringValue)!
    let tMax3 = Double(json["list"][24]["main"]["temp_max"].stringValue)!
    let tMax4 = Double(json["list"][32]["main"]["temp_max"].stringValue)!
    let tMax5 = Double(json["list"][39]["main"]["temp_max"].stringValue)!
    
    let tMin1 = Double(json["list"][5]["main"]["temp_min"].stringValue)!
    let tMin2 = Double(json["list"][13]["main"]["temp_min"].stringValue)!
    let tMin3 = Double(json["list"][21]["main"]["temp_min"].stringValue)!
    let tMin4 = Double(json["list"][29]["main"]["temp_min"].stringValue)!
    let tMin5 = Double(json["list"][37]["main"]["temp_min"].stringValue)!
    
    let temperaturaMax1 = Int(tMax1 - 273.15)
    let temperaturaMax2 = Int(tMax2 - 273.15)
    let temperaturaMax3 = Int(tMax3 - 273.15)
    let temperaturaMax4 = Int(tMax4 - 273.15)
    let temperaturaMax5 = Int(tMax5 - 273.15)
    
    let temperaturaMin1 = Int(tMin1 - 273.15)
    let temperaturaMin2 = Int(tMin2 - 273.15)
    let temperaturaMin3 = Int(tMin3 - 273.15)
    let temperaturaMin4 = Int(tMin4 - 273.15)
    let temperaturaMin5 = Int(tMin5 - 273.15)
    
    let ikona1 = Int(json["list"][8]["weather"][0]["id"].stringValue)!
    let ikona2 = Int(json["list"][16]["weather"][0]["id"].stringValue)!
    let ikona3 = Int(json["list"][24]["weather"][0]["id"].stringValue)!
    let ikona4 = Int(json["list"][32]["weather"][0]["id"].stringValue)!
    let ikona5 = Int(json["list"][39]["weather"][0]["id"].stringValue)!
    
    
    let niz = [temperaturaMax1, temperaturaMax2,temperaturaMax3,temperaturaMax4,temperaturaMax5]
    podaciMaxTemp = niz
    
    let niz1 = [temperaturaMin1, temperaturaMin2,temperaturaMin3,temperaturaMin4,temperaturaMin5]
    podaciMinTemp = niz1
    
    let nizIkona = [ikona1,ikona2,ikona3,ikona4,ikona5]
    ikonaVreme = nizIkona
    //
    //
    //      let vremeUnix = json["list"][8]["dt"].intValue
    //        let date = NSDate(timeIntervalSince1970: TimeInterval(vremeUnix))
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "EEEE"
    //        let vreme1 = formatter.string(from: date as Date)
    //        print(vreme1)
    //
    //        let nizVremena = [vremeUnix]
    //        prikazDatuma = nizVremena
}
}
