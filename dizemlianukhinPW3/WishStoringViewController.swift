//
//  WishStoringViewController.swift
//  dizemlianukhinPW3
//
//  Created by Denis Zemlyanukhin on 10.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let tableCornerRadius: CGFloat = 10
        static let tableOffset: CGFloat = 30
        static let firstWish: String = "I wish to add cells to the table"
        static let wishesCount: Int = 2
        static let one: Int = 1
        static let zeroSection: Int = 0
        static let secionNumberWithWishes: Int = 1
        static let wishesKey: String = "Wishes"
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private let defaults = UserDefaults.standard
    
    // MARK: - Variables
    private var wishArray: [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        wishArray = defaults.array(forKey: Constants.wishesKey) as? [String] ?? []
        view.backgroundColor = .blue
        configureTable()
    }
    
    // MARK: - Private methods
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Constants.zeroSection {
            return Constants.one
        }
        return wishArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constants.zeroSection {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.selectionStyle = .none
            if indexPath.row < wishArray.count {
                wishCell.configure(with: wishArray[indexPath.row])
            }
            
            return wishCell
        }
        
        if indexPath.row < wishArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.selectionStyle = .none
            wishCell.configure(with: wishArray[indexPath.row])
            
            return wishCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.addWish = { [weak self] wish in
                self?.wishArray.append(wish)
                self?.table.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            }
            
            return addWishCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.wishesCount
    }
}
