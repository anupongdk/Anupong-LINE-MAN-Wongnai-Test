//
//  CoinListView.swift
//  Anupong
//
//  Created gone on 23/1/2567 BE.
//  Copyright © 2567 BE ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol CoinListViewProtocol {
    func viewWillPresent(data: CoinList)
}

class CoinListView: UIViewController, CoinListViewProtocol {
    
    func viewWillPresent(data: CoinList) {
        
    }
  
    var viewModel : CoinListViewModel! {
        willSet {
            newValue.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchData()
    }
    
}

