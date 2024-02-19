//
//  MenuViewController.swift
//  MVVM_SnapKit
//
//  Created Jack Hamilton on 2/18/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	private var viewModel = MenuViewModel()
    var disposeBag = Set<AnyCancellable>()
    
    override func loadView() {
        view = MenuView()
        view.backgroundColor = UIColor.white
    }
    
    var customView: MenuView {
        return view as! MenuView
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableView.register(MenuRowCell.self, forCellReuseIdentifier: "cell")
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.estimatedRowHeight = 112
        
        viewModel.items.forEach({ item in
            item.$image.sink(receiveValue: { [weak self] _ in
                self?.customView.tableView.reloadData()
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
            cell.titleLabel.text = title
            cell.titleLabel.isHidden = false
            cell.titleLabel.isEnabled = true
        } else {
            cell.titleLabel.isHidden = true
            cell.titleLabel.isEnabled = false
        }
        
        cell.descriptionView.text = item.description
        
        if let image = item.image {
            cell.productImageView.image = image
            cell.productImageView.isHidden = false
        } else {
            cell.productImageView.isHidden = true
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

class MenuRowCell: UITableViewCell {
    var titleLabel = UILabel()
    var descriptionView = UITextView()
    var productImageView = UIImageView()
    var hostView = UIView()
    
    var heightConstraint: Constraint?
    var widthConstraint: Constraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(hostView)
        hostView.snp.removeConstraints()
        hostView.snp.makeConstraints({ make in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16).priority(249)
        })
        
        hostView.addSubview(titleLabel)
        hostView.addSubview(descriptionView)
        hostView.addSubview(productImageView)
        
        productImageView.snp.removeConstraints()
            productImageView.snp.makeConstraints({ make in
                make.top.right.bottom.equalToSuperview()
                make.height.equalTo(80)
                if productImageView.image != nil {
                    make.width.equalTo(80)
                } else {
                    make.width.equalTo(0)
                }
            })
            productImageView.layer.cornerRadius = 12
            productImageView.clipsToBounds = true
        
        
        titleLabel.snp.removeConstraints()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.snp.makeConstraints({ make in
            make.top.left.equalToSuperview()
            make.right.equalTo(productImageView.snp.left).inset(16)
            if titleLabel.isHidden {
                make.height.equalTo(0)
            }
        })
            
        
        descriptionView.snp.removeConstraints()
        descriptionView.font = .systemFont(ofSize: 16)
        descriptionView.isEditable = false
        descriptionView.isSelectable = false
        descriptionView.isScrollEnabled = false
        descriptionView.textContainer.lineFragmentPadding = CGFloat(0.0)
        descriptionView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        descriptionView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        descriptionView.snp.makeConstraints({ make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalTo(productImageView.snp.left)
            make.bottom.equalToSuperview().priority(249)
            make.height.equalTo(62)
        })
    }
}
