//
//  ScoreViewController.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-22.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {
    weak var delegate: ViewController?
    var flips: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = Colors.darkGrey
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 20
        
        let winLabel = UILabel()
        winLabel.text = "You won! Congrats 👏"
        winLabel.textColor = Colors.mintGreen
        winLabel.font = UIFont.systemFont(ofSize: 35.0)
        verticalStackView.addArrangedSubview(winLabel)
        
        let scoreLabel = UILabel()
        scoreLabel.text = "You made \(flips!) flips 🤖"
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.systemFont(ofSize: 30.0)
        verticalStackView.addArrangedSubview(scoreLabel)
        
        let playAgainButton = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        playAgainButton.layer.cornerRadius = 10.0
        playAgainButton.layer.masksToBounds = true
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.titleLabel?.textAlignment = .center
        playAgainButton.setGradientBackground(colorOne: Colors.mintGreen, colorTwo: Colors.darkGreen)
        playAgainButton.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        verticalStackView.addArrangedSubview(playAgainButton)
        playAgainButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        playAgainButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(verticalStackView)
        verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    @objc func startNewGame(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.startNewGame()
        }
        self.dismiss(animated: true)
    }
}
