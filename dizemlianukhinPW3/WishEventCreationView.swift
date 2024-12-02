//
//  WishEventCreationView.swift
//  dizemlianukhinPW3
//
//  Created by Denis Zemlyanukhin on 01.12.2024.
//

import UIKit

final class WishEventCreationView: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let spacing: CGFloat = 10
        static let spaceFromEdges: CGFloat = 20
        static let fieldHeight: CGFloat = 40
        static let cornerRadius: CGFloat = 10
        
        static let buttonTitle: String = "Add wish"
        static let buttonHeight: CGFloat = 60
    }
    
    // MARK: - Variables
    private var textFields: UIStackView = UIStackView()
    
    private var wishTitle: UITextField = UITextField()
    private var wishDescription: UITextField = UITextField()
    private var startDate: UITextField = UITextField()
    private var endDate: UITextField = UITextField()
    
    private var addWishButton: UIButton = UIButton()
    
    public var onAddWish: ((WishEventModel) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        configureTextFields()
        configureButton()
    }
    
    private func configureTextFields() {
        textFields.axis = .vertical
        view.addSubview(textFields)
        textFields.spacing = Constants.spacing
        
        for field in [wishTitle, wishDescription, startDate, endDate] {
            textFields.addArrangedSubview(field)
        }
        
        configureTitle()
        configureDescription()
        configureStartDate()
        configureEndDate()
        
        textFields.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        textFields.pinHorizontal(to: view, Constants.spaceFromEdges)
    }
    
    private func configureTitle() {
        wishTitle.placeholder = "Wish title"
        wishTitle.backgroundColor = .systemMint
        wishTitle.layer.cornerRadius = Constants.cornerRadius
        wishTitle.pinTop(to: textFields, Constants.spacing)
        wishTitle.pinHorizontal(to: textFields, Constants.spaceFromEdges)
        wishTitle.setHeight(Constants.fieldHeight)
    }
    
    private func configureDescription() {
        wishDescription.placeholder = "Wish description"
        wishDescription.backgroundColor = .systemMint
        wishDescription.layer.cornerRadius = Constants.cornerRadius
        wishDescription.pinTop(to: wishTitle.bottomAnchor, Constants.spacing)
        wishDescription.pinHorizontal(to: textFields, Constants.spaceFromEdges)
        wishDescription.setHeight(Constants.fieldHeight)
    }
    
    private func configureStartDate() {
        startDate.placeholder = "Start date"
        startDate.backgroundColor = .systemMint
        startDate.layer.cornerRadius = Constants.cornerRadius
        startDate.pinTop(to: wishDescription.bottomAnchor, Constants.spacing)
        startDate.pinHorizontal(to: textFields, Constants.spaceFromEdges)
        startDate.setHeight(Constants.fieldHeight)
    }
    
    private func configureEndDate() {
        endDate.placeholder = "End date"
        endDate.backgroundColor = .systemMint
        endDate.layer.cornerRadius = Constants.cornerRadius
        endDate.pinTop(to: startDate.bottomAnchor, Constants.spacing)
        endDate.pinHorizontal(to: textFields, Constants.spaceFromEdges)
        endDate.setHeight(Constants.fieldHeight)
    }
    
    private func configureButton() {
        view.addSubview(addWishButton)
        addWishButton.setTitle(Constants.buttonTitle, for: .normal)
        addWishButton.backgroundColor = .systemMint
        addWishButton.layer.cornerRadius = Constants.cornerRadius
        addWishButton.pinHorizontal(to: textFields, Constants.spaceFromEdges)
        addWishButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.spacing)
        addWishButton.setHeight(Constants.buttonHeight)
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addWishButtonPressed() {
        guard let title = wishTitle.text, !title.isEmpty,
              let description = wishDescription.text, !description.isEmpty,
              let start = startDate.text, !start.isEmpty,
              let end = endDate.text, !end.isEmpty else {
            showAlert("Заполните все поля")
            return
        }

        let wishEvent = WishEventModel(title: title, description: description, startDate: start, endDate: end)
        onAddWish?(wishEvent)
        dismiss(animated: true)
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}