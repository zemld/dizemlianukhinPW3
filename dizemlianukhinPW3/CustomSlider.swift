//
//  CustomSlider.swift
//  dizemlianukhinPW2
//
//  Created by Denis Zemlyanukhin on 29.10.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    private enum Constants {
        static let sliderTitleHeight: CGFloat = 10
        static let sliderLeadingConstraint: CGFloat = 20
        static let sliderHeight: CGFloat = 10
    }
    
    // MARK: - Variables
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()
    
    // MARK: - Lifecycle
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.sliderTitleHeight),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeadingConstraint),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.sliderHeight),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeadingConstraint)
            ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
