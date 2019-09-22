//
//  Product.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-19.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import Foundation

struct Product: Equatable {
    let id: Int
    let imageSrc: String
}

extension Product {
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let image = json["image"] as? [String: Any],
            let imageSrc = image["src"] as? String
        else {
            return nil
        }

        self.id = id
        self.imageSrc = imageSrc
    }
}
