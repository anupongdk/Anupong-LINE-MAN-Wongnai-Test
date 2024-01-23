//
//  CoinListViewModel.swift
//  Anupong
//
//  Created gone on 23/1/2567 BE.
//  Copyright © 2567 BE ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol CoinListViewModelProtocol {
    func fetchData()
    func didReceiveUISelect(object: CoinList)
}

class CoinListViewModel {
    var view : CoinListViewProtocol!
    var object = CoinList()
    
    func fetchData() {
        object.didFetch(withSuccess: { (success) in
            self.view.viewWillPresent(data: success)
        }) { (err) in
            debugPrint("Error happened", err as Any)
        }
    }
    
    func didReceiveUISelect(object: CoinList) {
        debugPrint("Did receive UI object", object)
    }
}
