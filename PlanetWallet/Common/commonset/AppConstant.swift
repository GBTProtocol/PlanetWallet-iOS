//
//  AppConstant.swift
//  PlanetWallet
//
//  Created by grabity on 01/05/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import Foundation
import UIKit

let DEFAULT_PLIST_NAME = "Preference"

//MARK: - Screen
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)



struct Keys {
    struct UserInfo {
        static let planet = "planet"
        static let fromSegue = "fromSegue"
        static let erc20 = "erc20"
        static let toPlanet = "toPlanet"
        static let transferAmount = "transferAmount"
        static let gasFee = "gasFee"
    }
    
    struct Userdefaults {
        static let THEME = "theme"
        static let PINCODE = "pincode"
        static let BIOMETRICS = "biometrics"
    }
    
    struct Segue {
        
        //Splash
        static let SPLASH_TO_PINCODE_REGISTRATION = "splash_to_pincoderegistration"
        static let SPLASH_TO_PINCODE_CERTIFICATION = "splash_to_pincodecertification"
        
        //PinCode
        static let PINCODE_REGISTRATION_TO_CERTIFICATION = "pincoderegistration_to_pincodecertification"
        static let PINCODE_CERTIFICATION_TO_PLANET_GENERATE = "pincodecertification_to_planetgenerate"
//        static let PINCODE_CERTIFICATION_TO_WALLETADD = "pincodecertification_to_walletadd"
        static let PINCODE_CERTIFICATION_TO_MAIN = "pincodecertification_to_main"
        static let PINCODE_CERTIFICATION_TO_REGISTRATION = "pincodecertification_to_pincoderegistration"
        static let PINCODE_CERTIFICATION_TO_MNEMONIC_EXPORT = "pincodecertification_to_mnemonicexport"
        static let PINCODE_CERTIFICATION_TO_PRIVATEKEY_EXPORT = "pincodecertification_to_privatekeyexport"
        static let PINCODE_CERTIFICATION_TO_TX_RECEIPT = "pincodecertification_to_txreceipt"
        
        //WALLET ADD
        static let WALLET_IMPORT_TO_MNEMONIC_IMPORT = "walletimport_to_mnemonicImport"
        static let WALLET_IMPORT_TO_PRIVATEKEY_IMPORT = "walletimport_to_privatekeyimport"
        static let WALLET_IMPORT_TO_JSON_IMPORT = "walletimport_to_jsonimport"
        static let WALLET_ADD_TO_PLANET_GENERATE = "walletadd_to_planetgenerate"
        static let PLANET_GENERATE_TO_MAIN = "planetgerate_to_mainnavigation"
        static let MNEMONIC_IMPORT_TO_PLANET_NAME = "mnemonicimport_to_planetname"
        static let JSON_IMPORT_TO_PLANET_NAME = "jsonimport_to_planetname"
        static let PRIVATEKEY_IMPORT_TO_PLANET_NAME = "privatekeyimport_to_planetname"
        
        
        //MAIN
        static let MAIN_TO_SETTING = "main_to_setting"
        static let MAIN_TO_TOKEN_ADD = "main_to_tokenadd"
        static let MAIN_TO_TRANSFER = "main_to_transfer"
        static let MAIN_NAVI_UNWIND = "unwind_to_mainnavi"
        static let MAIN_UNWIND = "unwind_to_main"
        static let MAIN_TO_PINCODECERTIFICATION = "main_to_pincodecertification"
        
        //Setting
        static let SETTING_TO_DETAIL_PLANET = "setting_to_detailplanet"
        static let SETTING_TO_PLANET_MANAGEMENT = "setting_to_planetmanagemnet"
        static let SETTING_TO_SECURITY = "setting_to_security"
        static let SETTING_TO_ANNOUNCEMENTS = "setting_to_announcements"
        static let SETTING_TO_FAQ = "setting_to_faq"
        
        //Setting_PlanetManagement
        static let PLANET_MANAGEMENT_TO_DETAIL_PLANET = "planetmanagement_to_detailplanet"
        static let PLANET_MANAGEMENT_TO_WALLET_ADD = "planetmanagement_to_walletadd"
        
        //Detail Plannet
        static let DETAIL_PLANET_TO_RENAME_PLANET = "detailplanet_to_renameplanet"
        static let MNEMONIC_EXPORT_TO_PINCODE_CERTIFICATION = "mnemonicexport_to_pincodecertification"
        static let PRIVATEKEY_EXPORT_TO_PINCODE_CERTIFICATION = "privatekeyexport_to_pincodecertification"
        
        //Detail setting
        static let SECURITY_TO_PINCODE_CERTIFICATION = "security_to_pincodecetrification"
        
        //Transfer
        static let TRANSFER_TO_QRCAPTURE = "transfer_to_qrcapture"
        static let TRANSFER_TO_TRANSFER_AMOUNT = "transfer_to_transferamount"
        static let TRANSFER_AMOUNT_TO_TRANSFER_CONFIRM = "transferamount_to_transferconfirm"
        static let TRANSFER_CONFIRM_TO_PINCODE_CERTIFICATION = "transferconfirm_to_pincodecertification"
    }
}
