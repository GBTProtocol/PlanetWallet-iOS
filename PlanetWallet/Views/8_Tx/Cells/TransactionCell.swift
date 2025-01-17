//
//  TransactionCell.swift
//  PlanetWallet
//
//  Created by grabity on 13/08/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit

class TransactionCell: PWTableCell {
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var directionImgView: UIImageView!
    @IBOutlet var statusLb: PWLabel!
    @IBOutlet var amountLb: PWLabel!
    @IBOutlet var symbolLb: PWLabel!
    @IBOutlet var currencyLb: PWLabel!
    
    
    override func commonInit() {
        super.commonInit()
        
        Bundle.main.loadNibNamed("TransactionCell", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(containerView)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        //No highlighted
    }

}
