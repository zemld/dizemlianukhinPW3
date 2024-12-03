//
//  WishCalendarViewController.swift
//  dizemlianukhinPW3
//
//  Created by Denis Zemlyanukhin on 30.11.2024.
//

import CoreData
import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let inset: CGFloat = 5
        static let contentInset: UIEdgeInsets = .init(top: inset, left: inset, bottom: inset, right: inset)
        static let cellHeight: CGFloat = 150
        static let userDefaultsKey: String = "scheduledWishes"
        
        static let spacingFromEdges: CGFloat = 40
        static let buttonBottomAnchor: CGFloat = 30
        static let buttonHeight: CGFloat = 60
        static let buttonTitle: String = "Add scheduled wish"
        static let cornerRadius: CGFloat = 20
    }
    
    private let colletionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let addScheduledWishButton: UIButton = UIButton()
    private let defaults = UserDefaults.standard
    private let calendarManager: CalendarManager = CalendarManager()
    
    // MARK: - Variables
    private var scheduledWishes: [WishEventModel] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        loadScheduledWishes()
        configureColletion()
        configureAddScheduledWishButton()
    }
    
    // MARK: - Private methods
    private func loadScheduledWishes() {
        if let data = UserDefaults.standard.data(forKey: Constants.userDefaultsKey),
           let wishes = try? JSONDecoder().decode([WishEventModel].self, from: data) {
            scheduledWishes = wishes
        }
    }

    private func configureColletion() {
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.backgroundColor = .white
        colletionView.alwaysBounceVertical = true
        colletionView.contentInset = Constants.contentInset
        
        view.addSubview(colletionView)
        
        colletionView.pinHorizontal(to: view)
        colletionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        colletionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        
        if let layout = colletionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            layout.invalidateLayout()
        }
        
        colletionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
    }
    
    private func configureAddScheduledWishButton() {
        view.addSubview(addScheduledWishButton)
        
        addScheduledWishButton.pinHorizontal(to: view, Constants.spacingFromEdges)
        addScheduledWishButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.buttonBottomAnchor)
        addScheduledWishButton.setHeight(Constants.buttonHeight)
        addScheduledWishButton.backgroundColor = .systemPink
        addScheduledWishButton.setTitle(Constants.buttonTitle, for: .normal)
        addScheduledWishButton.setTitleColor(.white, for: .normal)
        addScheduledWishButton.layer.cornerRadius = Constants.cornerRadius
        addScheduledWishButton.addTarget(self, action: #selector(addScheduledWishButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addScheduledWishButtonTapped() {
        let wishEventCreationView = WishEventCreationView()
        
        wishEventCreationView.onAddWish = { [weak self] newWish in
            guard let self = self else { return }

            let calendarEvent = CalendarEventModel(
                eventTitle: newWish.title,
                eventNote: newWish.description,
                eventStartDate: newWish.startDate,
                eventEndDate: newWish.endDate
            )

            let isEventCreated = self.calendarManager.create(eventModel: calendarEvent)
            if isEventCreated {
                print("Event added to calendar")
            } else {
                print("Failed to add event to calendar")
            }
            
            self.scheduledWishes.append(newWish)
            self.saveScheduledWishes()
            self.colletionView.reloadData()
        }
        
        present(wishEventCreationView, animated: true)
    }
    
    private func saveScheduledWishes() {
        if let data = try? JSONEncoder().encode(scheduledWishes) {
            UserDefaults.standard.set(data, forKey: Constants.userDefaultsKey)
        }
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
        return scheduledWishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else { return cell }
        
        let wishEvent = scheduledWishes[indexPath.item]
        wishEventCell.configure(with: wishEvent)
        saveScheduledWishes()
        
        return wishEventCell
    }
}

// MARK: - WishEventModel
struct WishEventModel: Codable {
    let title: String
    let description: String?
    let startDate: Date
    let endDate: Date
}
