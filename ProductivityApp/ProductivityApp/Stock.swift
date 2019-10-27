//
//  Stock.swift
//  calhacks-test-1
//
//  Created by Tan Zi Fan on 10/26/19.
//  Copyright © 2019 abcSup. All rights reserved.
//

class Stock {
    var title: String
    var subtitle: String
    var price: Double
    var change: Double
    
    init(title: String, subtitle: String, price: Double, change: Double) {
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.change = change
    }
}
