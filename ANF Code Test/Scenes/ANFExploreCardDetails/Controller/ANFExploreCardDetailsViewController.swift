//
//  ANFExploreCardDetailsViewController.swift
//  ANF Code Test
//
//  Created by Elle Kadfur on 1/18/23.
//

import UIKit

class ANFExploreCardDetailsViewController: UIViewController {
    
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var lblTopDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPromoMessage: UILabel!
    @IBOutlet weak var lblBottomDescription: UILabel!
    @IBOutlet weak var btnShop2: UIButton!
    @IBOutlet weak var btnShop1: UIButton!
    
    var productDetail: ProductData?
    var content = [ProductDetail]()
    var targetUrl = ""
    var targetUrl2 = ""
    var hyperLink: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetUp()
        guard content.count != 0 else { return }
        
        if content.count == 1 {
            btnShop2.isHidden = true
            btnShop1.isHidden = false
            btnShop1.setTitle(content[0].title ?? "", for: .normal)
            targetUrl = content[0].target ?? ""
            print(targetUrl)
        } else {
            btnShop2.isHidden = false
            btnShop1.isHidden = false
            btnShop1.setTitle(content[0].title ?? "", for: .normal)
            btnShop2.setTitle(content[1].title ?? "", for: .normal)
            targetUrl = content[0].target ?? ""
            targetUrl2 = content[1].target ?? ""
        }
    }
    
    //MARK: UiSetUp method
    func uiSetUp() {
        for btns in [btnShop1,btnShop2] {
            btns?.layer.borderColor = UIColor.black.cgColor
            btns?.layer.borderWidth = 1
        }
        btnShop1.isHidden = true
        btnShop2.isHidden = true
        let bgImage = productDetail?.backgroundImage ?? ""
        ivBackground.sd_setImage(with: URL(string: bgImage), completed: nil)
        lblTitle.text = productDetail?.title ?? ""
        lblPromoMessage.text = productDetail?.promoMessage ?? ""
        lblTopDescription.text = productDetail?.topDescription ?? ""
        lblBottomDescription.attributedText = NSAttributedString(html:  productDetail?.bottomDescription ?? "" )
        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)
        guard let detect = detector else { return }
        
        let matches = detect.matches(in: productDetail?.bottomDescription ?? "", options: .reportCompletion, range: NSMakeRange(0, (productDetail?.bottomDescription ?? "").count))
        
        for match in matches {
            print(match.url!)
            self.hyperLink = match.url!
        }
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.linkLabelTapped(_:)))
        self.lblBottomDescription.isUserInteractionEnabled = true
        self.lblBottomDescription.addGestureRecognizer(labelTap)
        
        content = productDetail?.content ?? []
    }
    
    ///linkLabelTapped action
    @objc func linkLabelTapped(_ sender: UITapGestureRecognizer) {
        if let url = self.hyperLink {
            UIApplication.shared.open(url)
        }
    }
    
    ///btnshop1Action
    @IBAction func btnShop1Action(_ sender: UIButton) {
        if let url = URL(string: targetUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    ///btnshop2Action
    @IBAction func btnShop2Action(_ sender: UIButton) {
        if let url = URL(string: targetUrl2) {
            UIApplication.shared.open(url)
        }
    }
    
}

