//
//  ViewController.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-10.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

protocol ModalHandler {
    func startNewGame()
}

class ViewController: UIViewController, ModalHandler {
    var game: GameController = GameController(numberOfPairs: 10)
    var cardButtons: [CardButton] = []
    var scoreLabel: UILabel!

    override func loadView() {
        super.loadView()
        setUpLayout()
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

    func setUpLayout() {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 20

        let appLogo = UIImage(named: "matchify")
        let appImageView = UIImageView(image: appLogo)
        appImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        appImageView.contentMode = .scaleAspectFit
        verticalStackView.addArrangedSubview(appImageView)

        scoreLabel = UILabel()
        scoreLabel.text = "Matches: \(game.matchesFound)"
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.systemFont(ofSize: 25.0)
        verticalStackView.addArrangedSubview(scoreLabel)

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

    func updateButtonViews(indeces: [Int]) {
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
                } else {
                    scoreLabel.text = "Matches: \(game.matchesFound)"
                    if game.matchesFound == 10 {
                        let scoreViewController = ScoreViewController()
                        scoreViewController.flips = game.flipsMade
                        scoreViewController.delegate = self
                        scoreViewController.modalPresentationStyle = .overCurrentContext
                        present(scoreViewController, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    func startNewGame() {
        print("DISMISSED")
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        cardButtons = []
        scoreLabel.text = "Matches: 0"
        game = GameController(numberOfPairs: 10)
        setUpLayout()
    }

    @objc func flipCard(sender: CardButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            updateButtonViews(indeces: [cardIndex])
            game.updateCard(at: cardIndex) { result in
                switch result {
                case .success(let indeces): self.updateButtonViews(indeces: indeces)
                case .failure(let error): print(error)
                }
            }
        }
    }
}
