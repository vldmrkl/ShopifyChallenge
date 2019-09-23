//
//  Card.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-21.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    var isFacedUp: Bool = false
    var isMatched: Bool = false
    var product: Product?
    var image: UIImage {
        get {
            if let product = product, let url = URL(string: product.imageSrc), let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    return image
                }
            }
            return UIImage()
        }
    }

    init(_ product: Product) {
        self.product = product
    }
}
