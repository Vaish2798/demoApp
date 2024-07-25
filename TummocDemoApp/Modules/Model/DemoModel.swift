//
//  File.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 24/07/24.
//

import Foundation
// MARK: - Welcome
class DemoModel: NSObject, Codable {
    var status: Bool?
    var message: String?
    var error: String?
    var categories: [Categories]?
}

// MARK: - Category
class Categories: NSObject, Codable {
    var id: Int?
    var name: String?
    var items: [Item]?
}
// MARK: - Item
class Item: NSObject, Codable {
    var id: Int?
    var name: String?
    var icon: String?
    var price: Double?
    var discount: Double?
    var isFavourite: Bool?
}
