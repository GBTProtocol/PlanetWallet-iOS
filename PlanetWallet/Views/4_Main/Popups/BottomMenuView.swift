//
//  BottomMeneView.swift
//  PlanetWallet
//
//  Created by 박상은 on 03/06/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit
import QRCode

protocol BottomMenuDelegate {
    func didTouchedCopy(_ addr: String)
    func didTouchedSend()
    func didTouchedSwitchItem()
}

/*
 Coin(ETH / BTC)과 관련된 팝업뷰
 */
class BottomMenuView: UIView {

    var delegate: BottomMenuDelegate?
    
    @IBOutlet var qrCodeImgView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var planetView: PlanetView!
    @IBOutlet var addressLb: UILabel!
    @IBOutlet var planetNameLb: UILabel!
    
    @IBOutlet var copyTopConstraint: NSLayoutConstraint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    //MARK: - Interface
    public func setPlanet(_ planet: Planet) {
        if let planetName = planet.name, let address = planet.address {
            self.planetNameLb.text = planetName
            self.planetView.data = address
            self.addressLb.text = address
            self.qrCodeImgView.image = QRCode(address)?.image
        }
    }
    
    //MARK: - Private
    private func commonInit() {
        Bundle.main.loadNibNamed("BottomMenuView", owner: self, options: nil)
        containerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: containerView.frame.height)
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.layer.cornerRadius = 25
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.masksToBounds = true
        self.addSubview(containerView)
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: containerView.frame.height)

        var qrCode = QRCode("ansrbthd")
        qrCode?.errorCorrection = .High
        self.qrCodeImgView.image = qrCode?.image
    }
    
    @IBAction func didTouchedCopy(_ sender: UIButton) {
        if let addr = addressLb.text {
            UIPasteboard.general.string = addr
            delegate?.didTouchedCopy(addr)
        }
    }
    
    @IBAction func didTouchedSend(_ sender: UIButton) {
        delegate?.didTouchedSend()
    }
}
