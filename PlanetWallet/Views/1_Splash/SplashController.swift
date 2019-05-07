//
//  ViewController.swift
//  PlanetWallet
//
//  Created by grabity on 01/05/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit

class SplashController: PlanetWalletViewController {
    
    private var isPinRegistered = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let _ = UserDefaults.standard.value(forKey: "pincode") else {
            isPinRegistered = false
            sendAction(segue: Keys.Segue.TO_PINCODE_REGISTRATION, userInfo: nil)
            return
        }
        
        if isPinRegistered {
            let pinCodeCertificationVC = UIStoryboard(name: "2_PinCode", bundle: nil).instantiateViewController(withIdentifier: "PinCodeCertificationController")
            self.present(pinCodeCertificationVC, animated: false, completion: nil)
        }
    }
}
