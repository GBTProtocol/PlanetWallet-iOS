//
//  PlanetNameController.swift
//  PlanetWallet
//
//  Created by grabity on 04/06/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit

class PlanetNameController: PlanetWalletViewController {
    @IBOutlet var planetBgView: PlanetView!
    @IBOutlet var planetView: PlanetView!
    @IBOutlet var confirmLb: UILabel!
    @IBOutlet var planetNameLb: UILabel!
    @IBOutlet var darkGradientView: GradientView!
    @IBOutlet var lightGradientView: GradientView!
    
    //MARK: - Init
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if( ThemeManager.currentTheme() == .DARK ){
            darkGradientView.isHidden = false
            lightGradientView.isHidden = true
        }else{
            darkGradientView.isHidden = true
            lightGradientView.isHidden = false
        }
    }
    
    override func viewInit() {
        super.viewInit()
    }
    
    //MARK: - IBAction
    @IBAction func didTouchedSelect(_ sender: UIButton) {
        performSegue(withIdentifier: Keys.Segue.MAIN_UNWIND, sender: nil)
//        if let _ = userInfo?["segue"] { //from main controller
//            performSegue(withIdentifier: Keys.Segue.MAIN_UNWIND, sender: nil)
//        }
//        else {
//            performSegue(withIdentifier: Keys.Segue.PLANET_GENERATE_TO_MAIN, sender: nil)
//        }
    }
    
    @IBAction func didTouchedClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
