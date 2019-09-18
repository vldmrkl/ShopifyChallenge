//
//  CardButton.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-16.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

class CardButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }

    func initButton() {
        setTitle("1", for: .normal)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
}
