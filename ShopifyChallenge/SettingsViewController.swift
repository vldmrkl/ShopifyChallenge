//
//  SettingsViewController.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-22.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    weak var delegate: ViewController?
    var slider = UISlider()
    var cardsInASetLabel = UILabel()
    var cardsInASet: Int = 2
    var prevValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "cardsInASet") != nil {
            self.cardsInASet = UserDefaults.standard.integer(forKey: "cardsInASet")
        }
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = Colors.darkGrey
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 20
        
        cardsInASetLabel.text = "Number of cards in a set: \(cardsInASet)"
        cardsInASetLabel.textColor = .white
        cardsInASetLabel.font = UIFont.systemFont(ofSize: 20.0)
        verticalStackView.addArrangedSubview(cardsInASetLabel)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.center = self.view.center
        slider.maximumValue = 5
        slider.minimumValue = 2
        slider.setValue(Float(cardsInASet), animated: false)
        slider.addTarget(self, action: #selector(changeValue(_:)), for: .valueChanged)
        verticalStackView.addArrangedSubview(slider)
        slider.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        slider.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.masksToBounds = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.textAlignment = .center
        saveButton.setGradientBackground(colorOne: Colors.mintGreen, colorTwo: Colors.darkGreen)
        saveButton.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        verticalStackView.addArrangedSubview(saveButton)
        saveButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(verticalStackView)
        verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    @objc func changeValue(_ sender: UISlider) {
        if Int(sender.value) == 3 {
            sender.setValue(4, animated: false)
        }
        
        cardsInASet = Int(sender.value)
        cardsInASetLabel.text = "Number of cards in a set: \(cardsInASet)"
    }
    
    @objc func saveSettings(sender: UIButton) {
        UserDefaults.standard.set(cardsInASet, forKey: "cardsInASet")
        if let delegate = self.delegate {
            delegate.startNewGame()
        }
        self.dismiss(animated: true)
    }
}
