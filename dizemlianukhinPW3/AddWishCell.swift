//
//  AddWishCell.swift
//  dizemlianukhinPW3
//
//  Created by Denis Zemlyanukhin on 10.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    // MARK: - Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetVertical: CGFloat = 5
        static let wrapOffsetHorizontal: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        static let wishText: String = "Enter a wish"
        static let textViewHeight: CGFloat = 80
        static let buttonHeight: CGFloat = 50
        static let margin: CGFloat = 16
        static let buttonTitle: String = "Add Wish"
        
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
    }
    
    private let wish: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton(type: .system)
    
    // MARK: - Variables
    var addWish: ((String) -> ())?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with wish: String) {
        self.wish.text = wish
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.translatesAutoresizingMaskIntoConstraints = false
        
        wrap.addSubview(wish)
        wrap.addSubview(addWishButton)
        
        // Настройка wish
        wish.backgroundColor = .clear
        wish.layer.borderColor = UIColor.lightGray.cgColor
        wish.layer.borderWidth = Constants.borderWidth
        wish.layer.cornerRadius = Constants.cornerRadius
        wish.text = Constants.wishText
        wish.textColor = .black
        wish.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка addWishButton
        addWishButton.setTitle(Constants.buttonTitle, for: .normal)
        addWishButton.layer.cornerRadius = Constants.cornerRadius
        addWishButton.backgroundColor = .systemGray6
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка констрейнтов с использованием методов из UIView+Pin
        wrap.pinTop(to: contentView.topAnchor, Constants.wrapOffsetVertical)
        wrap.pinBottom(to: contentView.bottomAnchor, Constants.wrapOffsetVertical)
        wrap.pinHorizontal(to: contentView, Constants.wrapOffsetHorizontal)
        
        wish.pinTop(to: wrap.topAnchor, Constants.wishLabelOffset)
        wish.pinHorizontal(to: wrap, Constants.wishLabelOffset)
        wish.setHeight(Constants.textViewHeight) // Устанавливаем минимальную высоту

        addWishButton.pinTop(to: wish.bottomAnchor, Constants.margin)
        addWishButton.pinHorizontal(to: wrap, Constants.margin)
        addWishButton.pinBottom(to: wrap.bottomAnchor, Constants.wrapOffsetVertical)
        addWishButton.setHeight(Constants.buttonHeight)
    }
//    private func configureUI() {
//        let wrap: UIView = UIView()
//        contentView.addSubview(wrap)
//        
//        wrap.backgroundColor = Constants.wrapColor
//        wrap.layer.cornerRadius = Constants.wrapRadius
//        wrap.pinVertical(to: self, Constants.wrapOffsetVertical)
//        wrap.pinHorizontal(to: self, Constants.wrapOffsetHorizontal)
//        
//        wrap.addSubview(wish)
//        wish.pin(to: wrap, Constants.wishLabelOffset)
//        wrap.addSubview(addWishButton)
//        
//        wish.backgroundColor = .clear
//        wish.layer.borderColor = UIColor.lightGray.cgColor
//        wish.layer.borderWidth = Constants.borderWidth
//        wish.layer.cornerRadius = Constants.cornerRadius
//        wish.text = Constants.wishText
//        wish.textColor = .black
//        wish.translatesAutoresizingMaskIntoConstraints = false
//        wish.setHeight(Constants.textViewHeight)
//        
//        addWishButton.setTitle(Constants.buttonTitle, for: .normal)
//        addWishButton.layer.cornerRadius = Constants.cornerRadius
//        addWishButton.backgroundColor = .systemGray6
//        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
//        addWishButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        addWishButton.topAnchor.constraint(equalTo: wrap.bottomAnchor, constant: Constants.margin).isActive = true
//        addWishButton.pinHorizontal(to: wrap, Constants.margin)
//    }
    
    // MARK: - Actions
    @objc
    private func addWishButtonPressed() {
        if let wishText = wish.text, !wishText.isEmpty {
            addWish?(wishText)
            wish.text = ""
        }
    }
}

