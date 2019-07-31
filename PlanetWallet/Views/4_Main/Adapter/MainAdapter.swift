//
//  ETHCoinDataSource.swift
//  PlanetWallet
//
//  Created by grabity on 21/05/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit

class MainAdapter: AbsTableViewAdapter<MainItem> {
    
    public let ethCellID = "ethereumCoinCell"
    public let btcCellID = "btcTransactionHistoryCell"
    
    override init(_ tableView: UITableView, _ dataSoruce: Array<MainItem>) {
        super.init(tableView, dataSoruce)
        registerCell(cellClass: ETHCoinCell.self, cellId: ethCellID)
        registerCell(cellClass: BTCTransactionCell.self, cellId: btcCellID)
    }
    
    //MARK: - TableView Datasource
    override func createCell(data: MainItem, position: Int) -> UITableViewCell? {
        guard let table = tableView else { return nil }
        
        if data.getCoinType() == CoinType.ERC20.coinType ||
            data.getCoinType() == CoinType.ETH.coinType
        {
            return table.dequeueReusableCell(withIdentifier: ethCellID)
        }
        else if data.getCoinType() == CoinType.BTC.coinType {
            return table.dequeueReusableCell(withIdentifier: btcCellID)
        }
        
        return nil
    }
    
    override func bindData(cell: UITableViewCell, data: MainItem, position: Int) {
        super.bindData(cell: cell, data: data, position: position)
        
        setCellHeight(height: 70)
        
        if data.getCoinType() == CoinType.ERC20.coinType {
            let erc20Cell = cell as? ETHCoinCell
            erc20Cell?.erc20 = data as? ERC20
        }
        else if data.getCoinType() == CoinType.BTC.coinType {
            //TODO: - BTC Binding
//            let btcCell = cell as? BTCTransactionCell
        }
        else if data.getCoinType() == CoinType.ETH.coinType {
            let ethCell = cell as? ETHCoinCell
            ethCell?.eth = data as? ETH
        }
    }
}
