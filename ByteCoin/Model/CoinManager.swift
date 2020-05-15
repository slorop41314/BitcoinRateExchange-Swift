//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coin : CoinModel)
    func didFailWithError(_ error : Error)
    
}
struct CoinManager {
    var delegate : CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C0BA7D21-7C16-4413-AD27-9E89EA4C2E8C"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func fetchCurrency (currencyCode : String) {
       let urlString = "\(baseURL)/\(currencyCode)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let data = data {
                    if let coin = self.parseJSON(currencyData: data) {
                        self.delegate?.didUpdateCoin(coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(currencyData : Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: currencyData)
            let coin = CoinModel(convertedCurrency: decodedData.rate, currentCurrency : decodedData.asset_id_quote)
            return coin
        }catch {
            print(error)
            return nil
        }
    }
}
