//
//  ForecastTableViewCell.swift
//  ShinyRainy
//
//  Created by Mikhail Kulichkov on 13/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var typeOfWeather: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillForecastCell(forecast: Forecast) {
        icon.image = UIImage(data: forecast.imageData)
        dayOfWeek.text = forecast.dayOfWeek
        let plusSignHigh = forecast.highTemp > 0 ? "+" : ""
        let plusSignLow = forecast.lowTemp > 0 ? "+" : ""
        highTemp.text = String(format:"\(plusSignHigh)%.0f Cº", forecast.highTemp)
        lowTemp.text = String(format:"\(plusSignLow)%.0f Cº", forecast.lowTemp)
        typeOfWeather.text = forecast.weatherType
    }
}
