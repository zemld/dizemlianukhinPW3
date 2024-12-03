//
//  WishEventCell.swift
//  dizemlianukhinPW3
//
//  Created by Denis Zemlyanukhin on 30.11.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    // MARK: - Constans
    private enum Constants {
        static let offset: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .systemCyan
        
        static let textColor: UIColor = .white
        static let titleTopOffset: CGFloat = 5
        static let titleLeading: CGFloat = 20
        static let titleSize: CGFloat = 20
        static let titleWeight: UIFont.Weight = .heavy
        static let titleFont: UIFont = .monospacedSystemFont(ofSize: titleSize, weight: titleWeight)
        
        static let descriptionTopOffset: CGFloat = 20
        static let descriptionSize: CGFloat = 15
        static let descriptionWeight: UIFont.Weight = .regular
        static let descriptionFont: UIFont = .monospacedSystemFont(ofSize: descriptionSize, weight: descriptionWeight)
        
        static let dateLeading: CGFloat = 20
        
        static let spacing: CGFloat = 5
    }
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let desctionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDesctionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        desctionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = Constants.textColor
        titleLabel.pinTop(to: wrapView, Constants.titleTopOffset)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureDesctionLabel() {
        addSubview(desctionLabel)
        desctionLabel.textColor = Constants.textColor
        desctionLabel.pinBottom(to: titleLabel, -Constants.descriptionTopOffset)
        desctionLabel.font = Constants.descriptionFont
        desctionLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = Constants.textColor
        startDateLabel.pinBottom(to: desctionLabel, -Constants.descriptionTopOffset)
        startDateLabel.font = Constants.descriptionFont
        startDateLabel.pinLeft(to: wrapView, Constants.dateLeading)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = Constants.textColor
        endDateLabel.pinBottom(to: startDateLabel, -Constants.descriptionTopOffset)
        endDateLabel.font = Constants.descriptionFont
        endDateLabel.pinLeft(to: wrapView, Constants.dateLeading)
    }
}
