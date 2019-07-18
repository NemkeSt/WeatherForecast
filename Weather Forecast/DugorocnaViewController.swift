//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Mac on 7/4/19.
//  Copyright © 2019 NemanjaStojanovic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class DugorocnaViewController: UIViewController, CLLocationManagerDelegate {
   

    @IBOutlet weak var tabela: UITableView!
    
    
    let APP_ID = "f1ed699121010b8edde35d96b089b1ae"
    let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast"
    
    let locationDelegate = CLLocationManager()
    let vremeDataModel = WeatherDataModel()
    
    var podaciMaxTemp = [Int]()
    var podaciMinTemp = [Int]()
    var ikonaVreme = [Int]()
    var prikazDatuma = [Int]()
    
    var max : Int = 0
    var min : Int = 0
    var ikona : Int = 0
    var dayOfAWeek : String = ""
   
    
    var arrayMax = [Int]()
    var arrayMin = [Int]()
    var arrayIcon = [Int]()
    var arrayDayOfAWeek = [String]()
    

    
    
    
    
    func getForecast(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Succes! Got the weather data forecast")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                
                for (_, value):(String,JSON) in weatherJSON["list"] {
                 self.dayOfAWeek = value["dt_txt"].stringValue
                 self.ikona = value["weather"][0]["id"].intValue
                 self.max = value["main"]["temp_max"].intValue
                 self.min = value["main"]["temp_min"].intValue
            
                    
                    if self.dayOfAWeek.contains("15:00:00")  {
                        self.getDate()
                        self.arrayMax.append(self.max - 273)
                        self.arrayIcon.append(self.ikona)
                          
                      
                    }
                    if self.dayOfAWeek.contains("03:00:00") {
                       self.arrayMin.append(self.min - 273)
                    }
                    
           
                }
               
                self.tabela.reloadData()
                
                
            }
            else {
                print("Error \(response.result.error)")
                
               
            }
            
        }
        
    }
    
    func getDate() {
        let longDateFormatter = DateFormatter()
        longDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = longDateFormatter.date(from: self.dayOfAWeek) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd"
            let convertedDate = dateFormatter.string(from: date)
            self.arrayDayOfAWeek.append(convertedDate)
            print (convertedDate)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lokacija = locations[locations.count - 1]
        if lokacija.horizontalAccuracy > 0 {
            locationDelegate.stopUpdatingLocation()
            let  longitude = String(lokacija.coordinate.longitude)
            let latitude = String(lokacija.coordinate.latitude)
            print("longitude = \(lokacija.coordinate.longitude), latitude = \(lokacija.coordinate.latitude)")
            
            let podaci: [String:String] = ["lon" : longitude, "lat" : latitude, "appid": APP_ID]
            
            
            getForecast(url: FORECAST_URL, parameters: podaci)
            
        }
        
    }
    
   

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationDelegate.delegate = self
        locationDelegate.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationDelegate.requestWhenInUseAuthorization()
        locationDelegate.startUpdatingLocation()
        tabela.backgroundView = nil
        tabela.backgroundColor = UIColor.clear
        
       
        tabela.tableFooterView = UIView()
   
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
}
    


extension DugorocnaViewController : UITableViewDataSource, UITableViewDelegate {

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "celija", for: indexPath) as! MyCell
            
            cell.backgroundColor = .clear
            cell.MaxTemp.text = "\(arrayMax[indexPath.row])°"
            cell.MinTemp.text = "\(arrayMin[indexPath.row])°"
            cell.slika.image = UIImage(named: vremeDataModel.updateWeatherIcon(condition: arrayIcon[indexPath.row]))
            cell.day.text = "\(arrayDayOfAWeek[indexPath.row])"
            
            
            return cell
        }

    
   
    }

