//
//  MenuRowViewModel.swift
//  MVVM_SwiftUI
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
import SwiftUI
import Combine

@Observable
class MenuRowViewModel: ObservableObject {
    var title: String?
    var description: String
    var image: UIImage?
    
    var disposeBag = Set<AnyCancellable>()
    var service: DataLoaderService?
    
    init(item: MenuItem) {
        self.title = item.title
        self.description = item.description
        self.image = nil
        //Service needs to be stored in order for the sink to be retained when we go out of the init scope
        if let imageURL = item.imageURL {
            service = DataLoaderService(urlString: imageURL)
            //When the data is done fetching, update our image
            service?.$data.sink(receiveValue: { [weak self] data in
                if let image = UIImage(data: data) {
                    self?.image = image
                }
            })
            .store(in: &disposeBag)
        }
    }
}
