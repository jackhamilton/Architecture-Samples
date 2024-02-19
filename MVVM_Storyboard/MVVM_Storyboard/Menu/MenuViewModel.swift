//
//  MenuViewModel.swift
//  MVVM_Storyboard
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine
import UIKit

class MenuViewModel {
    var items: [MenuItem]
    
    init() {
        if let path = Bundle.main.path(forResource: "Response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let menu = try JSONDecoder().decode(Model.self, from: data)
                items = menu.contentItems.map({ contentItem in
                    return MenuItem(item: contentItem)
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
    
    var disposeBag = Set<AnyCancellable>()
    var service: DataLoaderService?
    
    init(item: ContentItem) {
        self.title = item.title
        self.description = item.description
        self.image = nil
        
        if let url = item.imageURL {
            service = DataLoaderService(urlString: url)
            service?.$data.sink(receiveValue: { [weak self] data in
                self?.image = UIImage(data: data)
            })
            .store(in: &disposeBag)
        }
    }
}
