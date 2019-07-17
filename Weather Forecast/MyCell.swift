//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Mac on 7/4/19.
//  Copyright © 2019 NemanjaStojanovic. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    
    @IBOutlet weak var MaxTemp: UILabel!
    @IBOutlet weak var MinTemp: UILabel!
    @IBOutlet weak var slika: UIImageView!
    @IBOutlet weak var day: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
}
