//
//  WishMakerViewController.swift
//  dizemlianukhinPW2
//
//  Created by Denis Zemlyanukhin on 28.10.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let titleFontSize: CGFloat = 32
        static let titleHeight: CGFloat = 30
        
        static let descriptionFontSize: CGFloat = 16
        static let descriptionHeight: CGFloat = 10
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let minValue: CGFloat = 0
        static let maxValue: CGFloat = 1
        
        static let cornerRadius: CGFloat = 20
        static let bottomAnchor: CGFloat = 30
        static let sidesSpace: CGFloat = 40
        static let buttonBottomAnchor: CGFloat = 20
        static let stackSize: CGFloat = 150
        static let buttonHeight: CGFloat = 60
        static let buttonWidth: CGFloat = 160
        static let spacing: CGFloat = 10
        
        static let animationTime: TimeInterval = 0.5
        
        static let title: String = "Wish Maker"
        static let slogan: String = "Create a wish and share it with your friends"
        static let textForHidingSliders: String = "Hide sliders"
        static let textForAddingWish: String = "Add wish"
    }
    
    private let addWishButton: UIButton = UIButton(type: .system)
    
    // MARK: - Variables
    private var titleView: UILabel = UILabel()
    private var descriptionView: UILabel = UILabel()
    private var toggleButton: UIButton = UIButton()
    private var slidersStack: UIStackView = UIStackView()
    
    private var areSlidersVisible: Bool = true
    
    private var redValue: CGFloat = 0
    private var greenValue: CGFloat = 0
    private var blueValue: CGFloat = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = .systemTeal
        
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureToggleButton()
        configureSliders()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.title
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleView.textColor = .systemIndigo
        
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesSpace),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleHeight)
        ])
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.slogan
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionView.textColor = .systemPurple
        
        view.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesSpace),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.descriptionHeight)])
    }
    
    private func configureSliders() {
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.axis = .vertical
        view.addSubview(slidersStack)
        slidersStack.layer.cornerRadius = Constants.cornerRadius
        slidersStack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.minValue, max: Constants.maxValue)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.minValue, max: Constants.maxValue)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.minValue, max: Constants.maxValue)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            slidersStack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            slidersStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidesSpace),
            slidersStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidesSpace),
            slidersStack.bottomAnchor.constraint(equalTo: toggleButton.topAnchor, constant: -Constants.spacing)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
                    self?.redValue = CGFloat(value)
                    self?.updateBackgroundColor()
        }
                
        sliderGreen.valueChanged = { [weak self] value in
            self?.greenValue = CGFloat(value)
            self?.updateBackgroundColor()
        }
                
        sliderBlue.valueChanged = { [weak self] value in
            self?.blueValue = CGFloat(value)
            self?.updateBackgroundColor()
        }
    }
    
    private func configureToggleButton() {
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setTitle(Constants.textForHidingSliders, for: .normal)
        toggleButton.backgroundColor = .systemBlue
        toggleButton.layer.cornerRadius = Constants.cornerRadius
        toggleButton.addTarget(self, action: #selector(buttonToggled), for: .touchUpInside)
        
        view.addSubview(toggleButton)
        toggleButton.setHeight(Constants.buttonHeight)
        toggleButton.pinHorizontal(to: view, Constants.sidesSpace)
        
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: -Constants.spacing)
        ])
    }
    
    private func configureAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.bottomAnchor)
        addWishButton.pinHorizontal(to: view, Constants.sidesSpace)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.textForAddingWish, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.cornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func updateBackgroundColor() {
        view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }
    
    @objc
    private func buttonToggled() {
        self.areSlidersVisible.toggle()
        self.toggleButton.isEnabled = false
        
        UIView.animate(withDuration: Constants.animationTime,
                       animations: {
            self.slidersStack.alpha = self.areSlidersVisible ? 1 : 0
        }, completion: { [weak self] _ in
            self?.toggleButton.isEnabled = true
            self?.slidersStack.isHidden = !self!.areSlidersVisible
            let buttonTitle = self!.areSlidersVisible ? "Hide sliders" : "Show sliders"
            self?.toggleButton.setTitle(buttonTitle, for: .normal)})
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}
