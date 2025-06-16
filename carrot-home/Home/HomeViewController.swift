//
//  HomeViewController.swift
//  carrot-home
//
//  Created by 이종원 on 6/17/25.
//

import UIKit
import Combine

// 홈 뷰모델 만들기 (리스트 가져오기, 아이템 탭 했을때 정의 하기)
// 뷰 모델은 리스트 가죠오기


class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModel = HomeViewModel(network: NetworkService(configuration: .default))
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetch()
    }
    
    private func bind() {
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { items in
                print("items: \(items)")
            }.store(in: &subscriptions)
        
        viewModel.itemTapped
            .sink { item in
                let sb = UIStoryboard(name: "Detail", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
    }
}

//@IBAction func ctaButtonTapped(_ sender: Any) {
//    let sb = UIStoryboard(name: "Detail", bundle: nil)
//    let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//    navigationController?.pushViewController(vc, animated: true)
//}
