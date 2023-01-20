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
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        attributedString.addAttributes([ NSAttributedString.Key.paragraphStyle: style], range: NSMakeRange(0, attributedString.length))
        self.init(attributedString: attributedString)
    }
}

//MARK: UITableView
extension UITableView {
    
    /// setEmptyMessage in tableview
    func setEmptyMessage(_ message: String, font: UIFont?, textColor: UIColor?) {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView = messageLabel;
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
        ])
        
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = font ?? UIFont.systemFont(ofSize: 23)
        messageLabel.textColor = textColor ?? UIColor.gray
        messageLabel.sizeToFit()
        
    }
}

extension UIViewController {
    
    /// This will show an simple alert with a message
    /// - parameter Message : Message You want to show to the user
    func showSimpleAlert(Message : String){
        let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
