//
//  Extensions.swift
//  ANF Code Test
//
//  Created by Elle Kadfur on 1/18/23.
//

import UIKit

//MARK: Convert Html to NSAttributedString
extension NSAttributedString {
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return nil }
        
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: style], range: NSMakeRange(0, attributedString.length))
        self.init(attributedString: attributedString)
    }
}
