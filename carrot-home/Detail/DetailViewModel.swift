//
//  DetailViewModel.swift
//  carrot-home
//
//  Created by 이종원 on 6/18/25.
//

import Foundation
import Combine

final class DetailViewModel {
    
    let network: NetworkService
    let itemInfo: ItemInfo
    
    @Published var itemInfoDetails: ItemInfoDetails? = nil
    
    init(network: NetworkService, itemInfo: ItemInfo) {
        self.network = network
        self.itemInfo = itemInfo
    }
    
    func fetch() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [unowned self] in
            self.itemInfoDetails = ItemInfoDetails(user: User.mock, item: self.itemInfo, details: ItemExtraInfo.mock)
            }
        //        let resource: Resource<ItemInfoDetails> = Resource(base: "", path: "")
        //        network.load(resource)
        //            .receive(on: RunLoop.main)
    }

}

