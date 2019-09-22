//
//  Service.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-19.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import Foundation

class Service {
    let API_URL = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")

    func fetchProducts(handler: @escaping (Result<[Product], Error>) -> Void) {
        URLSession.shared.dataTask(with: API_URL!) { (data, response, error) in
            var productsFromJson: [Product] = []
            if let responseData = data, error == nil {
                do {
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                        for case let products in json["products"] as! [[String: Any]] {
                            if let product = Product(json: products) {
                                productsFromJson.append(product)
                            }
                        }
                    }
                    handler(.success(productsFromJson))
                } catch {
                    handler(.failure(error))
                }
            }
        }.resume()
    }
}
