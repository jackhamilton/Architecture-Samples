//
//  MenuViewModel.swift
//  MVVM_SnapKit
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

class MenuViewModel {
    var items: [MenuItem]
    
    init() {
        if let path = Bundle.main.path(forResource: "Response", ofType: "json") {
            do {
                //Fetch the data, convert it into menuitems
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let menu = try JSONDecoder().decode(Menu.self, from: data)
                self.items = menu.contentItems.map({
                    MenuItem(item: $0)
                })
            } catch {
                print(error)
                self.items = []
            }
        } else {
            self.items = []
        }
    }
}

class MenuItem: ObservableObject {
    var title: String?
    var description: String
    
    @Published var image: UIImage?
    var service: DataLoaderService?
    var disposeBag = Set<AnyCancellable>()
    
    init(item: ContentItem) {
        title = item.title
        description = item.description
        image = nil
        if let imageURL = item.imageURL {
            service = DataLoaderService(urlString: imageURL)
            service?.$data.sink(receiveValue: { [weak self] data in
                self?.image = UIImage(data: data)
            })
            .store(in: &disposeBag)
        }
    }
}
