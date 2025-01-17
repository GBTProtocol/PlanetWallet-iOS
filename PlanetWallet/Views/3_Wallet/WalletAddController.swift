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
    @IBOutlet var createPlanetBtn: PWButton!
    @IBOutlet var importPlanetBtn: PWButton!
    
    //MARK: - Init
    override func viewInit() {
        if let _ = userInfo?[Keys.UserInfo.fromSegue] {
            //from main controller
            closeBtn.isHidden = false
        }
        else {
            closeBtn.isHidden = true
        }
    }
    
    //MARK: - IBAction
    @IBAction func didTouchedCreatePlanet(_ sender: UIButton) {
        let popup = PopupUniverse()
        
        popup.show(controller: self)
        popup.handler = { [weak self] (coinType) in
            guard let strongSelf = self else { return }
            popup.dismiss()
            
            if let fromSegue = strongSelf.userInfo?[Keys.UserInfo.fromSegue] as? String {
                let isFromMain = fromSegue == Keys.Segue.MAIN_TO_WALLET_ADD ? true : false
                
                let userInfo = [Keys.UserInfo.universe : coinType.name,
                                Keys.UserInfo.fromSegue : Keys.Segue.WALLET_ADD_TO_PLANET_GENERATE,
                                "isFromMain" : isFromMain] as [String : Any]
                strongSelf.sendAction(segue: Keys.Segue.WALLET_ADD_TO_PLANET_GENERATE,
                                      userInfo: userInfo)
            }
            else {
                strongSelf.sendAction(segue: Keys.Segue.WALLET_ADD_TO_PLANET_GENERATE,
                                      userInfo: [Keys.UserInfo.universe : coinType.name])
            }
        }
    }
    
    @IBAction func didTouchedImportPlanet(_ sender: UIButton) {
        let popup = PopupUniverse()
        
        popup.show(controller: self)
        popup.handler = { [weak self] (coinType) in
            guard let strongSelf = self else { return }
            popup.dismiss()
            
            guard let fromSegue = strongSelf.userInfo?[Keys.UserInfo.fromSegue] as? String else { return }
            
            let isFromMain = fromSegue == Keys.Segue.MAIN_TO_WALLET_ADD ? true : false
            let userInfo = [Keys.UserInfo.universe : coinType.name,
                            "isFromMain" : isFromMain] as [String : Any]
            
            if let importPlanetController = UIStoryboard(name: "3_Wallet", bundle: nil).instantiateViewController(withIdentifier: "WalletImportController") as? WalletImportController {
                
                importPlanetController.userInfo = userInfo
                strongSelf.presentDetail(importPlanetController)
            }
        }
    }
    
    @IBAction func didTouchedCloseBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
