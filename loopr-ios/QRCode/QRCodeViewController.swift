//
//  QRCodeViewController.swift
//  loopr-ios
//
//  Created by xiaoruby on 2/25/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var qrcodeImageView: UIImageView!
    var qrcodeImage: CIImage!

    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var copyAddressButton: UIButton!
    @IBOutlet weak var saveToAlbumButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = NSLocalizedString("QR Code", comment: "")
        
        view.theme_backgroundColor = GlobalPicker.backgroundColor
        addressLabel.theme_textColor = GlobalPicker.textColor
        addressLabel.font = UIFont.init(name: FontConfigManager.shared.getRegular(), size: 14)

        // copyAddressButton.theme_backgroundColor = ["#000", "#fff"]
        // copyAddressButton.theme_setTitleColor(["#fff", "#000"], forState: .normal)

        copyAddressButton.setTitle(NSLocalizedString("Copy Wallet Address", comment: ""), for: .normal)
        copyAddressButton.backgroundColor = UIColor.clear
        copyAddressButton.titleColor = UIColor.black
        copyAddressButton.layer.cornerRadius = 23
        copyAddressButton.layer.borderWidth = 0.5
        copyAddressButton.layer.borderColor = UIColor.black.cgColor
        copyAddressButton.titleLabel?.font = UIFont(name: FontConfigManager.shared.getBold(), size: 16.0)

        saveToAlbumButton.setTitle(NSLocalizedString("Save to Album", comment: ""), for: .normal)
        saveToAlbumButton.backgroundColor = UIColor.black
        saveToAlbumButton.layer.cornerRadius = 23
        saveToAlbumButton.titleLabel?.font = UIFont(name: FontConfigManager.shared.getBold(), size: 16.0)
        
        setBackButton()

        let address = CurrentAppWalletDataManager.shared.getCurrentAppWallet()?.address
        addressLabel.text = address

        let data = address?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        qrcodeImage = filter!.outputImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Remove the blur effect
        let scaleX = qrcodeImageView.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrcodeImageView.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        qrcodeImageView.image = UIImage.init(ciImage: transformedImage)
    }

    @IBAction func pressedCopyAddressButton(_ sender: Any) {
        let address = CurrentAppWalletDataManager.shared.getCurrentAppWallet()!.address
        print("pressedCopyAddressButton address: \(address)")
        UIPasteboard.general.string = address
    }

    @IBAction func pressedSaveToAlbum(_ sender: Any) {
        let address = CurrentAppWalletDataManager.shared.getCurrentAppWallet()!.address
        print("pressedSaveToAlbum address: \(address)")
    }

}
