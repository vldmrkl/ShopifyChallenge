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
    var numberOfSets: Int
    var cardsInASet: Int
    var products: [Product] = [] {
        didSet {
            for product in products {
                createPairFor(product)
            }
            cards.shuffle()
        }
    }
    var openedCardIndex: Int?
    var openedCardsIndeces: [Int] = []
    var matchesFound: Int = 0
    var currentMatches: Int = 0
    var flipsMade: Int = 0
    
    init(cardsNumber: Int, cardsInASet: Int) {
        self.numberOfSets = cardsNumber / cardsInASet
        self.cardsInASet = cardsInASet
        cards = []
        fetchData()
    }
    
    func updateCard(at index: Int, handler: @escaping (Result<[Int], Error>) -> Void) {
        flipsMade += 1
        if !cards[index].isMatched {
            if openedCardsIndeces.count > 0 && !openedCardsIndeces.contains(index) {
                cards[index].isFacedUp = true
                let indexOfOpenedCard = openedCardsIndeces[0]
                self.openedCardsIndeces.append(index)
                if cards[index].product == cards[indexOfOpenedCard].product {
                    currentMatches += 1
                    if currentMatches == cardsInASet - 1 {
                        for index in openedCardsIndeces {
                            cards[index].isMatched = true
                        }
                        matchesFound += 1
                        currentMatches = 0
                        self.openedCardsIndeces = []
                    }
                } else {
                    currentMatches = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        for index in self.openedCardsIndeces {
                            self.cards[index].isFacedUp = false
                        }
                        let copyIndeces = self.openedCardsIndeces
                        self.openedCardsIndeces = []
                        handler(.success(copyIndeces))
                    }
                }
                handler(.success([index]))
            } else {
                openedCardsIndeces.append(index)
                openedCardIndex = index
                cards[index].isFacedUp = true
                handler(.success(openedCardsIndeces))
            }
        }
    }
    
    func fetchData() {
        service.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products): self?.products = Array(products[0 ..< self!.numberOfSets])
                case .failure: self?.products = []
                }
            }
        }
    }
    
    func createPairFor(_ product: Product) {
        let card = Card(product)
        for _ in 0 ..< cardsInASet {
            cards.append(card)
        }
    }
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
