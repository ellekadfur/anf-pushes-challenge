//
//  ANFExploreCardViewModel.swift
//  ANF Code Test
//
//  Created by Elle Kadfur on 1/18/23.
//

import Foundation

typealias bindFail = ((_ message: String) -> ())

//MARK: ANFExploreCardViewModel
class ANFExploreCardViewModel {
    
    private var failBlock: bindFail? = nil
    private lazy var exploreCardRepo: ANFExploreCardRepo = ANFExploreCardRepo()
    var PeoductList: Observable<[ProductData]> = .init([])
    
    init(_ bindFailure: @escaping bindFail) {
        self.failBlock = bindFailure
        reloadData()
    }
    
    /// getProductList
    func getProductList() {
        exploreCardRepo.getProductListJson(jsonUrl: "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json") { status, errorMsg, resultData  in
            if status {
                self.PeoductList.value = resultData ?? []
            } else {
                self.failBlock?(errorMsg)
            }
        }
    }
    
    /// reloadData
    func reloadData() {
        getProductList()
    }
}
