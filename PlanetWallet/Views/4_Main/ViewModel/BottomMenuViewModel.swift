//
//  BottomMenuViewModel.swift
//  PlanetWallet
//
//  Created by grabity on 08/08/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import Foundation
import UIKit

class BottomMenuViewModel {
    var currentIdx = 0
    var items: [MainItem]!
    
    var symbolText = ""
    var balance = ""
    var coinImgPath = ""
    
    init(planet: Planet) {
        
        guard let coinType = planet.coinType, let balance = planet.balance else { return }
        
        if coinType == CoinType.BTC.coinType {
            self.symbolText = "BTC"
            self.balance = balance
            
            if let resourcePath = Bundle.main.resourcePath {
                let imgName = "tokenIconBTC.png"
                self.coinImgPath = resourcePath + "/" + imgName
            }
        }
        else {
            if let items = planet.items {
                self.items = items
                filterItems()
            }
            
            self.symbolText = "ETH"
            self.balance = balance
            
            if let resourcePath = Bundle.main.resourcePath {
                let imgName = "tokenIconETH.png"
                self.coinImgPath = resourcePath + "/" + imgName
            }
        }
        
        
    }
    
    func didSwitched() {
        if items.isEmpty { return }
        
        guard let item = switchItem() else {
            currentIdx = 0
            didSwitched()
            return
        }
        
        if let eth = item as? ETH {
            self.symbolText = eth.symbol
            self.balance = eth.balance
            
            if let resourcePath = Bundle.main.resourcePath {
                let imgName = "tokenIconETH.png"
                self.coinImgPath = resourcePath + "/" + imgName
            }
        }
        else if let erc20 = item as? ERC20, let symbol = erc20.symbol, let balance = erc20.balance, let imgPath = erc20.img_path {
            self.symbolText = symbol
            self.balance = balance
            self.coinImgPath = imgPath
        }
    }
    
    var filteredItems: [MainItem]?
    
    private func filterItems() {
        filteredItems = items.filter({ (item) -> Bool in
            if let eth = item as? ETH, let balance = Double(eth.balance) {
                if balance > 0 {
                    return true
                }
            }
            else if let erc20 = item as? ERC20, let balanceStr = erc20.balance, let balance = Double(balanceStr) {
                if balance > 0 {
                    return true
                }
            }
            return false
        })
        
        
    }
    
    private func switchItem() -> MainItem? {
        currentIdx += 1
        
        if currentIdx >= items.count {
            currentIdx = 0
        }
        
        for i in currentIdx..<items.count {
            
            if let eth = items[i] as? ETH, let balance = Double(eth.balance) {
                if balance > 0 {
                    currentIdx = i
                    return eth
                }
            }
            else if let erc20 = items[i] as? ERC20, let balanceStr = erc20.balance, let balance = Double(balanceStr) {
                if balance > 0 {
                    currentIdx = i
                    return erc20
                }
            }
        }
        
        return nil
    }

}
