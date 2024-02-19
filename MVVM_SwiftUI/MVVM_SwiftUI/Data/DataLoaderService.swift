//
//  DataLoaderService.swift
//  MVVM_SwiftUI
//
//  Created by Jack Hamilton on 2/18/24.
//

import Foundation

class DataLoaderService: ObservableObject {
    @Published var data: Data = Data()
    
    //Once the data is fetched, the publisher will update. Sink the publisher, and we'll get the data back.
    init(urlString: String) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.data = data
                }
            }
            task.resume()
        }
    }
}
