//
//  OpenOrderTableViewCell.swift
//  loopr-ios
//
//  Created by xiaoruby on 2/12/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import UIKit

class OpenOrderTableViewCell: UITableViewCell {

    var order: Order?
    
    @IBOutlet weak var tradingPairLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var filledPieChart: CircleChart!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        theme_backgroundColor = GlobalPicker.backgroundColor
        tradingPairLabel.theme_textColor = GlobalPicker.textColor
        amountLabel.theme_textColor = ["#a0a0a0", "#fff"]
        filledPieChart.theme_backgroundColor = GlobalPicker.backgroundColor
        
        filledPieChart.strokeColor = Themes.isNight() ? UIColor.white.cgColor : UIColor.black.cgColor
        filledPieChart.textColor = Themes.isNight() ? UIColor.white : UIColor.black
        filledPieChart.textFont = UIFont.systemFont(ofSize: 12)
        
        let num = Int(arc4random_uniform(100))
        filledPieChart.percentage = CGFloat(num)/100
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update() {
        guard let order = order else {
            return
        }
        tradingPairLabel.text = order.tradingPairDescription
    }
    
    class func getCellIdentifier() -> String {
        return "OpenOrderTableViewCell"
    }
    
    class func getHeight() -> CGFloat {
        return 90
    }
}
