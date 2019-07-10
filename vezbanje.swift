//
//  vezbanje.swift
//  
//
//  Created by Mac on 7/5/19.
//

import Foundation
import SwiftyJSON


let json = "{ \"people\": [{ \"firstName\": \"Paul\", \"lastName\": \"Hudson\", \"isAlive\": true }, { \"firstName\": \"Angela\", \"lastName\": \"Merkel\", \"isAlive\": true }, { \"firstName\": \"George\", \"lastName\": \"Washington\", \"isAlive\": false } ] }"


for item in json["people"].arrayValue {
    print(item["firstName"].stringValue)
}
