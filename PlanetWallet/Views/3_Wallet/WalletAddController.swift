//
//  WalletAddController.swift
//  PlanetWallet
//
//  Created by grabity on 01/05/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit

class WalletAddController: PlanetWalletViewController {
    
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var createPlanetBtn: PWButton!{
        didSet {
            createPlanetBtn.titleLabel?.font = Utils.shared.planetFont(style: .SEMIBOLD, size: 18)
        }
    }
    @IBOutlet var importPlanetBtn: PWButton!{
        didSet {
            importPlanetBtn.titleLabel?.font = Utils.shared.planetFont(style: .SEMIBOLD, size: 18)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = userInfo?["segue"] {
            //from main controller
            closeBtn.isHidden = false
        }
        else {
            closeBtn.isHidden = true
        }
    }
    
    @IBAction func didTouchedCreatePlanet(_ sender: UIButton) {
        
        if let segue = userInfo?["segue"] as? String, segue == Keys.Segue.PINCODE_CERTIFICATION_TO_WALLETADD {
            //from certification
            sendAction(segue: Keys.Segue.WALLET_ADD_TO_PALNET_GENERATE, userInfo: nil)
        }
        else {
            //from settings
            let popup = PopupUniverse()
            
            popup.show(controller: self)
            popup.handler = { [weak self] (universe) in
                guard let strongSelf = self else { return }
                popup.dismiss()
                
                if let fromSegue = strongSelf.userInfo?["segue"] as? String {
                    let userInfo = ["universe" : universe.description(), "segue" : fromSegue]
                    strongSelf.sendAction(segue: Keys.Segue.WALLET_ADD_TO_PALNET_GENERATE,
                                          userInfo: userInfo)
                }
                else {
                    strongSelf.sendAction(segue: Keys.Segue.WALLET_ADD_TO_PALNET_GENERATE,
                                          userInfo: ["universe" : universe.description()])
                }
            }
        }
    }
    
    @IBAction func didTouchedImportPlanet(_ sender: UIButton) {
        
        let importPlanetController = UIStoryboard(name: "3_Wallet", bundle: nil).instantiateViewController(withIdentifier: "WalletImportController")
        self.presentDetail(importPlanetController)
    }
    
    @IBAction func didTouchedCloseBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
