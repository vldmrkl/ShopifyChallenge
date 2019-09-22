//
//  GameController.swift
//  ShopifyChallenge
//
//  Created by Volodymyr Klymenko on 2019-09-21.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import Foundation

class GameController {
    private let service = Service()
    var cards: [Card] = []
    var numberOfPairs: Int
    var products: [Product] = [] {
        didSet {
            for product in products {
                createPairFor(product)
            }
            cards.shuffle()
        }
    }
    var openedCardIndex: Int?
    var matchesFound: Int = 0

    init(numberOfPairs: Int) {
        self.numberOfPairs = numberOfPairs
        fetchData()
    }

    func updateCard(at index: Int, handler: @escaping (Result<[Int], Error>) -> Void) {
        if !cards[index].isMatched {
            if let openedCardIndex = openedCardIndex, index != openedCardIndex {
                cards[index].isFacedUp = true
                if cards[index].product == cards[openedCardIndex].product {
                    cards[index].isMatched = true
                    cards[openedCardIndex].isMatched = true
                    matchesFound += 1
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self.cards[index].isFacedUp = false
                        self.cards[openedCardIndex].isFacedUp = false
                        handler(.success([index, openedCardIndex]))
                    }
                }
                self.openedCardIndex = nil
                handler(.success([index]))
            } else {
                openedCardIndex = index
                cards[index].isFacedUp = true
                handler(.success([index]))
            }
        }
    }

    func fetchData() {
        service.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products): self?.products = Array(products[0 ..< 10])
                case .failure: self?.products = []
                }
            }
        }
    }

    func createPairFor(_ product: Product) {
        let card = Card(product)
        cards += [card, card]
    }
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
