//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Albert Stanley on 15/05/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let convertedCurrency : Double
    let currentCurrency : String
    var stringCurrency : String {
        String(format: "%.1f", convertedCurrency)
    }
}
