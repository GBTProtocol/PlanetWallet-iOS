//
//  TokenListView.swift
//  PlanetWallet
//
//  Created by grabity on 01/05/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit

class TokenListController: PlanetWalletViewController {
    
    private var planet:Planet?
    
    private var tokenAdapter: TokenAdapter?
    
    @IBOutlet var textFieldContainer: PWView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var notFoundLb: UILabel!
    @IBOutlet var magnifyingImgView: PWImageView!
    
    var tokenList: [ERC20] = [ERC20]()
    
    var search:String=""
    var isSearching = false {
        didSet {
            if isSearching {
                notFoundLb.isHidden = !(tokenAdapter?.dataSource.isEmpty)!
                tableView.isHidden = tokenList.isEmpty
            }
            else {
                notFoundLb.isHidden = true
                tableView.isHidden = false
            }
        }
    }
    
    //MARK: - Init
    override func viewInit() {
        super.viewInit()
        
        //set textfield
        if let placeHolderFont = Utils.shared.planetFont(style: .REGULAR, size: 14) {
            textField.attributedPlaceholder = NSAttributedString(string: "token_list_search_title".localized,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: currentTheme.detailText,
                                                                              NSAttributedString.Key.font: placeHolderFont])
        }
        textField.delegate = self
    }
    
    override func setData() {
        super.setData()
        
        if let userInfo = self.userInfo,
            let planet = userInfo[Keys.UserInfo.planet] as? Planet
        {
            self.planet = planet
            
            tokenAdapter = TokenAdapter(tableView, tokenList)
            tokenAdapter?.delegates.append(self)
            
            Get(self).action(Route.URL("erc20"), requestCode: 0, resultCode: 0, data: nil)
            
        }
    }
    
    override func onUpdateTheme(theme: Theme) {
        super.onUpdateTheme(theme: theme)
        textField.attributedPlaceholder = NSAttributedString(string: "token_list_search_title".localized,
                                                             attributes: [NSAttributedString.Key.foregroundColor: currentTheme.detailText])
    }
    
    
    //MARK: - Network
    override func onReceive(_ success: Bool, requestCode: Int, resultCode: Int, statusCode: Int, result: Any?, dictionary: Dictionary<String, Any>?) {
        if let dict = dictionary, let keyId = planet?.keyId {
            if let returnVo = ReturnVO(JSON: dict){
                if( returnVo.success! ){
                    tokenList.removeAll()
                    
                    let dbItems = try! PWDBManager.shared.select(ERC20.self, "ERC20", "keyId = '\(keyId)' AND hide='N'")
                    var dbMaps = Dictionary<String, ERC20>()
                    
                    
                    dbItems.forEach { (erc20) in
                        dbMaps[erc20.contract!] = erc20
                    }
                    
                    let items = returnVo.result as! Array<Dictionary<String, Any>>
                    print(items)
                    items.forEach { (item) in
                        let erc20 = ERC20(JSON: item)!
                        erc20.hide = "Y"
                        if( dbMaps[erc20.contract!] != nil ){
                            erc20.hide = dbMaps[erc20.contract!]!.hide
                        }
                        tokenList.append(erc20)
                    }
                    tokenAdapter?.dataSetNotify(tokenList)
                }
            }
        }
    }
}

extension TokenListController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // DataBase Input
        if let erc20 = tokenAdapter?.dataSource[indexPath.row],
            let keyId = planet?.keyId,
            let erc20Contract = erc20.contract
        {
            var isUpdated = false
            
            erc20.keyId = planet?.keyId
            erc20.hide = "N"
            let list: Array<ERC20> = try! PWDBManager.shared.select(ERC20.self, "ERC20", "keyId='\(keyId)'")
            
            list.forEach { (erc) in
                
                if( erc.contract == erc20.contract ){
                    erc20.hide = erc.hide == "N" ? "Y" : "N"
                    _ = PWDBManager.shared.update(erc20, "keyId='\(keyId)' AND contract='\(erc20Contract)'")
                    isUpdated = true
                    return
                }
            }
            
            if !isUpdated {
                _ = PWDBManager.shared.insert(erc20)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        findAllViews(view: cell, theme: currentTheme)
    }
}


extension TokenListController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
 
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.search = ""
        isSearching = false
        tokenAdapter?.dataSetNotify(tokenList)
        textField.resignFirstResponder()
        return true
    }
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        magnifyingImgView.image = currentTheme.magnifyingPointImg
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isSearching = false
        magnifyingImgView.image = currentTheme.magnifyingImg
    }
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { //backspace
            search = String(search.dropLast())
            if search.isEmpty {
                isSearching = false
                tokenAdapter?.dataSetNotify(tokenList)
                return true
            }
        }
        else {
            search = textField.text! + string
        }
 
        tokenAdapter?.dataSetNotify(tokenList.filter({
            guard let name = $0.name?.uppercased(), let symbol = $0.symbol?.uppercased() else { return false }
            
            return name.contains(search.uppercased()) || symbol.contains(search.uppercased())
        }))
        
        isSearching = true
        
        return true
    }
}
