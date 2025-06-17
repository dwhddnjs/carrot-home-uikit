//
//  DetailViewController.swift
//  carrot-home
//
//  Created by 이종원 on 6/17/25.
//

import UIKit
import Combine
import Kingfisher

class DetailViewController: UIViewController {
    
    // user
    @IBOutlet weak var userTemperature: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userThumbnail: UIImageView!
    
    
    // Item
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemThumbnail: UIImageView!
    @IBOutlet weak var itemInfoTitle: UILabel!
    @IBOutlet weak var itemInfoDescription: UILabel!
    
    var viewModel: DetailViewModel!
    var subscription = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        bind()
        viewModel.fetch()
    }
    
    private func setupUI() {
        userThumbnail.layer.masksToBounds = true
        userThumbnail.layer.cornerRadius = 40
    }
    
    private func bind() {
        viewModel.$itemInfoDetails
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { details in
                self.userThumbnail.kf.setImage(with: URL(string: details.user.thumnail))
                self.userTemperature.text = "\(details.user.temperature)°C"
                self.userLocation.text = details.user.location
                self.userNickName.text = details.user.name
                
                self.itemThumbnail.kf.setImage(with: URL(string: details.item.thumbnailURL))
                self.itemInfoDescription.text = details.details.descriptions
                self.itemPriceLabel.text = "\(self.formatNumber(details.item.price)) 원"
            }.store(in: &subscription)
    }

    private func configureNavigationBar() {
        
        let moreConfig = CustomBarItemConfiguration(
            title: nil,
            image: UIImage(systemName: "ellipsis"),
            handler: {print("more view")}
        )
        let moreItem = UIBarButtonItem.generate(
            with: moreConfig,
            width: 30
        )
    
        let shareConfig = CustomBarItemConfiguration(
            title: nil,
            image: UIImage(systemName: "square.and.arrow.up"),
            handler: {print("share view")}
        )
        let shareItem = UIBarButtonItem.generate(with: shareConfig, width: 30)
        
        
        navigationItem.rightBarButtonItems = [moreItem, shareItem]
        navigationItem.backButtonDisplayMode = .minimal
    }
}

extension DetailViewController {
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        return result
    }
}
