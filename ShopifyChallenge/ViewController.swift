//
//  ViewController.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-10.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game: GameController = GameController(numberOfPairs: 10)
    var cardButtons: [CardButton] = []

    override func loadView() {
        super.loadView()
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 20
        verticalStackView.backgroundColor = .green

        for _ in 0..<5 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .equalSpacing
            stackView.spacing = 10

            for _ in 0..<4 {
                let cardButton = CardButton(frame: CGRect(x: 0, y: 0, width: 75, height: 85))
                cardButtons.append(cardButton)
                cardButton.setImage(UIImage(named: "question-mark.png"), for: .normal)
                cardButton.addTarget(self, action: #selector(flipCard), for: .touchUpInside)
                stackView.addArrangedSubview(cardButton)
            }
            stackView.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.addArrangedSubview(stackView)
        }
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(verticalStackView)
        verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for cardButton in cardButtons {
            cardButton.setGradientBackground(colorOne: Colors.purple, colorTwo: Colors.darkPurple)
        }
    }

    func updateButtonsViews(indeces: [Int]) {
        for index in indeces {
            let btn = cardButtons[index]
            if !game.cards[index].isFacedUp {
                btn.setImage(UIImage(named: "question-mark.png"), for: .normal)
                UIView.transition(with: btn, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            } else {
                btn.setImage(game.cards[index].image, for: .normal)
                btn.imageView?.frame = CGRect(x: 0, y: 0, width: 75, height: 85)
                if !game.cards[index].isMatched {
                    UIView.transition(with: btn, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                }
            }
        }
    }

    @objc func flipCard(sender: CardButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            updateButtonsViews(indeces: [cardIndex])
            game.updateCard(at: cardIndex) { result in
                switch result {
                case .success(let indeces): self.updateButtonsViews(indeces: indeces)
                case .failure(let error): print(error)
                }
            }
        }
    }
}

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
