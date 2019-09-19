//
//  CardButton.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-16.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

class CardButton: UIButton {
    var isFacedUp: Bool = false
    var isMatched: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
        print(state)
    }

    func initButton() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        addTarget(self, action: #selector(flip), for: .touchUpInside)
    }

    @objc func flip(sender: UIButton) {
        if isFacedUp {
            isFacedUp.toggle()
            setImage(UIImage(named: "question-mark.png"), for: .normal)
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else {
            isFacedUp.toggle()
            setImage(UIImage(named: "robot.png"), for: .normal)
            imageView?.frame = CGRect(x: 0, y: 0, width: 75, height: 85)
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)

        }
    }
}
