//
//  TransferController.swift
//  PlanetWallet
//
//  Created by grabity on 01/05/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import UIKit
import AVFoundation

extension TransferController {
    enum State {
        case DEFAULT
        case NOT_FOUND
        case RESULTS
    }
}

class TransferController: PlanetWalletViewController {

    private let contactCellID = "contactCell"
    private let contactAddressCellID = "contractAddressCell"
    @IBOutlet var naviBar: NavigationBar!
    @IBOutlet var textField: PWTextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var notFoundLb: PWLabel!
    @IBOutlet var paseClipboardBtn: UIButton!
    
    var state: State = .DEFAULT {
        didSet {
            updateUI()
        }
    }
    
    var contactList: [String] = []
    var contactListFiltered: [String] = []
    
    var search:String = ""
    var isSearching = false {
        didSet {
            if isSearching {
                if contactListFiltered.isEmpty {
                    state = .NOT_FOUND
                }
                else {
                    state = .RESULTS
                }
            }
            else {
                state = .DEFAULT
            }
        }
    }
    
    //MARK: - Init
    override func viewInit() {
        super.viewInit()
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: contactCellID)
        tableView.register(ContactAddrCell.self, forCellReuseIdentifier: contactAddressCellID)
        naviBar.delegate = self
    }
    
    //MARK: - IBAction
    @IBAction func didTouchedPasteClipboard(_ sender: UIButton) {
        if let copiedStr = Utils.shared.getClipboard() {
            textField.text = copiedStr
            tableView.reloadData()
        }
    }
    
    //MARK: - Private
    private func updateUI() {
        switch state {
        case .DEFAULT:
            self.tableView.isHidden = true
            self.notFoundLb.isHidden = true
            if let _ = Utils.shared.getClipboard() {
                self.paseClipboardBtn.isHidden = false
            }
            else {
                self.paseClipboardBtn.isHidden = true
            }
        case .NOT_FOUND:
            self.tableView.isHidden = true
            self.notFoundLb.isHidden = false
            self.paseClipboardBtn.isHidden = true
        case .RESULTS:
            self.tableView.isHidden = false
            self.notFoundLb.isHidden = true
            self.paseClipboardBtn.isHidden = true
        }
    }
    
    /*
    private var session: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var qrCodeFrameView: UIView?
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.qr]
    
    @IBOutlet var addressLb: UILabel!
    
    @IBOutlet var slider: PWSlider!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkClipboard()
    }
    
    override func onUpdateTheme(theme: Theme) {
        super.onUpdateTheme(theme: theme)
        
        self.addressLb.setColoredAddress()
    }
    
    private func checkClipboard() {
        if let copiedStr = Utils.shared.getClipboard() {
            
        }
    }
    
    
    private func configurateCapture() {
        if session == nil {
            session = AVCaptureSession()
        }
        
        configurateSession()
        configurePreviewLayer()
        configureDetectedQRCodeFrameView()
        
        session?.startRunning()
    }
    
    private func configurateSession() {
        guard let session = session else { return }
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInWideAngleCamera],
                                                                      mediaType: .video, position: .back)
        do {
            guard let captureDevice = deviceDiscoverySession.devices.first else {
                NSLog("Failed to get the camera device")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
            
            let output = AVCaptureMetadataOutput()
            session.addOutput(output)
            
            output.setMetadataObjectsDelegate(self, queue: .main)
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        }
        catch {
            NSLog(error.localizedDescription)
            return
        }
    }
    
    private func configurePreviewLayer() {
        guard let session = session else { return }
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.bounds
        view.layer.addSublayer(previewLayer!)
    }

    private func configureDetectedQRCodeFrameView() {
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    private func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    @IBAction func didTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTouchedQRCode(_ sender: UIButton) {
        Toast(text: "Copied to Clipboard").show()
        /*
        if session == nil {
            session = AVCaptureSession()
        }
        guard let session = session else { return }
        
        if session.isRunning {
            session.stopRunning()
        }
        else {
            configurateCapture()
        }
         */
    }
    */
}
/*
extension TransferController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            NSLog("No qr code is detected")
            return
        }
        
        let metaObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metaObj.type) {
            
            if metaObj.stringValue != nil {
                
                if let matched = matches(for: "0x[0-9a-fA-F]{40}$", in: metaObj.stringValue!).first {
                    print(matched)
                }
            }
        }
    }
}
*/

extension TransferController: NavigationBarDelegate {
    func didTouchedBarItem(_ sender: ToolBarButton) {
        if sender == .LEFT {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            
        }
    }
}

extension TransferController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        findAllViews(view: cell, theme: currentTheme)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: contractCellID) as! ContactCell
        let cell = tableView.dequeueReusableCell(withIdentifier: contactAddressCellID, for: indexPath) as! ContactAddrCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    
}

extension TransferController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.search = ""
        isSearching = false
        tableView.reloadData()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isSearching = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { //backspace
            search = String(search.dropLast())
            if search.isEmpty {
                isSearching = false
                self.tableView.reloadData()
                return true
            }
        }
        else {
            search = textField.text! + string
        }
        
        //TODO: - API Network
//        self.contactListFiltered = contactList.filter({ return $0.name.uppercased().contains(search.uppercased()) })
        isSearching = true
        
        self.tableView.reloadData()
        return true
    }
}

