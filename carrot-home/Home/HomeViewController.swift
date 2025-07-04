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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = ItemInfo
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    let viewModel: HomeViewModel = HomeViewModel(network: NetworkService(configuration: .default))
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel.fetch()
        bind()
        
    }
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemInfoCell", for: indexPath) as? ItemInfoCell else {return nil}
            cell.configure(item: item)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems([], toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func applyItems(_ items: [ItemInfo]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.delegate = self
    }
    
    private func bind() {
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { items in
                self.applyItems(items)
            }.store(in: &subscriptions)
        
        viewModel.itemTapped
            .sink { item in
                let sb = UIStoryboard(name: "Detail", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                vc.viewModel = DetailViewModel(network: NetworkService(configuration: .default), itemInfo: item)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(140))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        viewModel.itemTapped.send(item)
    }
}

