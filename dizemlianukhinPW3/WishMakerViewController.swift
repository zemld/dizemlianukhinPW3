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
        static let bottomAnchor: CGFloat = 230
        static let leadingAnchor: CGFloat = 20
        static let buttonBottomAnchor: CGFloat = 20
        static let buttonHeight: CGFloat = 60
        static let buttonWidth: CGFloat = 160
        
        static let animationTime: TimeInterval = 0.5
    }
    
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
        configureSliders()
        configureToggleButton()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = "Wish Maker"
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleView.textColor = .systemIndigo
        
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleHeight)
        ])
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = "Create a wish and share it with your friends"
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionView.textColor = .systemPurple
        
        view.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
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
            slidersStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slidersStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            slidersStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.bottomAnchor)
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
        toggleButton.setTitle("Hide sliders", for: .normal)
        toggleButton.backgroundColor = .systemBlue
        toggleButton.layer.cornerRadius = Constants.cornerRadius
        toggleButton.addTarget(self, action: #selector(buttonToggled), for: .touchUpInside)
        
        view.addSubview(toggleButton)
        
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.topAnchor.constraint(equalTo: slidersStack.bottomAnchor, constant: Constants.buttonBottomAnchor),
            toggleButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            toggleButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)])
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
}
