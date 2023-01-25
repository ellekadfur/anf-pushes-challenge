//
//  ProductListModel.swift
//  ANF Code Test
//
//  Created by Elle Kadfur on 1/18/23.
//

import Foundation
// MARK: - ProductData
struct ProductData: Codable {
    let title: String?
    let backgroundImage: String?
    let content: [ProductDetail]?
    let promoMessage, topDescription, bottomDescription: String?
}

// MARK: - ProductDetail
struct ProductDetail: Codable {
    let target: String?
    let title, elementType: String?
}
