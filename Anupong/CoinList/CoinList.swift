//
//  CoinList.swift
//  Anupong
//
//  Created gone on 23/1/2567 BE.
//  Copyright © 2567 BE ___ORGANIZATIONNAME___. All rights reserved.


/// CoinList Model
struct  CoinList {
    typealias didFetchSuccess = (CoinList)->()
    typealias didFailWithError = (Error?) -> ()
    
    // Your Model Structure
    var id : Int?
    var name : Int?
    
    func didFetch(withSuccess: @escaping didFetchSuccess, withError: @escaping didFailWithError) {
        withSuccess(CoinList())
        withError(nil)
    }
}


