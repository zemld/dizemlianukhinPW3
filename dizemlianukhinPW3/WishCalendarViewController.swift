//
//  WishCalendarViewController.swift
//  dizemlianukhinPW3
//
//  Created by Denis Zemlyanukhin on 30.11.2024.
//

import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let inset: CGFloat = 5
        static let contentInset: UIEdgeInsets = .init(top: inset, left: inset, bottom: inset, right: inset)
        static let cellHeight: CGFloat = 150
    }
    private let colletionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configureColletion()
    }
    
    // MARK: - Private methods
    private func configureColletion() {
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.backgroundColor = .white
        colletionView.alwaysBounceVertical = true
        colletionView.contentInset = Constants.contentInset
        
        // Temporary.
        colletionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(colletionView)
        
        colletionView.pinHorizontal(to: view)
        colletionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        colletionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        
        if let layout = colletionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            layout.invalidateLayout()
        }
        
        // Temporary.
        colletionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
    }
}

// MARK: - UIColletionViewDelegate
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell tapped at index \(indexPath.item).")
    }
}

// MARK: - UIColletionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else { return cell }
        wishEventCell.configure(with: WishEventModel(
            title: "Test",
            description: "Test description",
            startDate: "Start date",
            endDate: "End date"
        ))
        
        return wishEventCell
    }
}
