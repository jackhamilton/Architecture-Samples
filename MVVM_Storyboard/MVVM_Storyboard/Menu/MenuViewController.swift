//
//  MenuViewController.swift
//  MVVM_Storyboard
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit
import Combine

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var viewModel = MenuViewModel()

	init() {
        super.init(nibName: "MenuView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var tableView: UITableView!
    var disposeBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RowCell", bundle: nil), forCellReuseIdentifier: "cell")
//        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.items.forEach({ item in
            item.$image.sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &disposeBag)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MenuRowCell else {
            fatalError()
        }
        let item = viewModel.items[indexPath.row]
        if let title = item.title {
            cell.productTitle.text = item.title
            cell.productTitle.isHidden = false
        } else {
            cell.productTitle.isHidden = true
        }
        cell.productDescription.text = item.description
        if let image = item.image {
            cell.productImage.image = image
            cell.productImage.isHidden = false
        } else {
            cell.productImage.isHidden = true
        }
        cell.productImage.layer.cornerRadius = 12
        cell.productImage.layer.masksToBounds = true
        cell.productImage.layer.borderWidth = 0
        return cell
    }
}

class MenuRowCell: UITableViewCell {
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
}
