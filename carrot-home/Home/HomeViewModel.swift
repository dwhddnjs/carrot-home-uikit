//
//  HomeViewModel.swift
//  carrot-home
//
//  Created by 이종원 on 6/17/25.
//

import Foundation
import Combine

final class HomeViewModel {
    let network: NetworkService
    
    @Published var items: [ItemInfo] = []
    
    let itemTapped = PassthroughSubject<ItemInfo, Never>()
    var subscription = Set<AnyCancellable>()
    let serverURL = Bundle.main.object(forInfoDictionaryKey: "ServerURL") as! String
    
    init(network: NetworkService) {
        print(serverURL)
        self.network = network
    }
    
    func fetch() {
        let resource: Resource<[ItemInfo]> = Resource(
            base: serverURL,
            path: "cafielo/demo/products",
            params: [:],
            header: ["Content-Type":"application/json"],
        )
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("error: \(error)")
                case .finished:
                    print("피니시")
                }
            } receiveValue: { items in
                self.items = items
            }.store(in: &subscription)
    }
}
