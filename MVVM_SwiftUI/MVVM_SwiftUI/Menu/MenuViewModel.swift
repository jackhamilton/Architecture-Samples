//
//  MenuViewModel.swift
//  MVVM_SwiftUI
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
import SwiftUI

@Observable
class MenuViewModel {
    var items: [MenuItem]
    
    init() {
        //Fetch and decode the Response.json file into MenuItems
        if let path = Bundle.main.path(forResource: "Response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let menu = try JSONDecoder().decode(Menu.self, from: data)
                self.items = menu.items
            } catch {
                print(error)
                self.items = []
            }
        } else {
            self.items = []
        }
    }
}
