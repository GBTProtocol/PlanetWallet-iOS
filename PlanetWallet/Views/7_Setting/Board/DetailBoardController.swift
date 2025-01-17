//
//  DetailAnnouncementsController.swift
//  PlanetWallet
//
//  Created by grabity on 13/05/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit
import WebKit

class DetailBoardController: PlanetWalletViewController {
    @IBOutlet var naviBar: NavigationBar!
    @IBOutlet var boardSubjectLb: UILabel!
    @IBOutlet var boardDateLb: UILabel!
    var webView: WKWebView!
    @IBOutlet var webViewContainer: UIView!
    
    override func viewInit() {
        super.viewInit()
        
        naviBar.delegate = self
        
        webView = WKWebView()
        webView.backgroundColor = .clear
        webView.scrollView.delegate = self
        webViewContainer.addSubview(webView)
    }
    
    override func setData() {
        super.setData()
        
        if let userInfo = userInfo,
            let board = userInfo["board"] as? Board,
            let section = userInfo["section"] as? BoardController.Category,
            let date = board.created_at,
            let boardID = board.id
        {
            naviBar.title = section.localized()
            boardSubjectLb.text = board.subject
            boardDateLb.text = Utils.shared.changeDateFormat(date: date,
                                                             beforFormat: .BASIC,
                                                             afterFormat: .yyyyMMdd)
            
            self.request(url: Route.URL("board",
                                        section.urlParam(),
                                        "\(boardID)?theme=\(( settingTheme == .DARK ? "black" : "white" ))"))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = webViewContainer.bounds
        print(webView.frame)
    }
    
    func request(url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
    }
}

extension DetailBoardController: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        //disable pinch zooming
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}

extension DetailBoardController: NavigationBarDelegate {
    func didTouchedBarItem(_ sender: ToolBarButton) {
        if sender == .LEFT {
            navigationController?.popViewController(animated: true)
        }
    }
}
