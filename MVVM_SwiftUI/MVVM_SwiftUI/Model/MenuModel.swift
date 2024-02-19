//
//  MenuModel.swift
//  MVVM_SwiftUI
//
//  Created by Jack Hamilton on 2/18/24.
//

import Foundation
import SwiftUI

struct Menu: Codable {
    var items: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case items = "content_items"
    }
}

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    var title: String?
    var imageURL: String?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imageURL = "image_url"
        case description = "description"
    }
}
