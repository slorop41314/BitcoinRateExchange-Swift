//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cryptoImage: UIImageView!
    @IBOutlet weak var convertedCryptoValue: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }


}
extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchCurrency(currencyCode: coinManager.currencyArray[row])
    }
}

extension HomeViewController: CoinManagerDelegate {
    func didUpdateCoin(_ coin: CoinModel) {
        DispatchQueue.main.async {
            self.convertedCryptoValue.text = coin.stringCurrency
            self.currencyLabel.text = coin.currentCurrency
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}
