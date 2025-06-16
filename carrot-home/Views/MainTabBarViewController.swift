//
//  MainTabBarViewController.swift
//  carrot-home
//
//  Created by 이종원 on 6/17/25.
//

import UIKit

// [0] 탭이 눌릴때마다 그에 맞는 네비게이션을 바를 구성
// - [0] 탭이 눌리는 것을 감지
// - [0] 감지후에 그 탭에 맞게 네비게이션 바를 구성을 업데이트 해줘야겠다

// 앱이 시작할때 네비게이션 바 아이템 설정을 완료하고 싶다
// - 네비게이션 바

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationItem(vc: self.selectedViewController!)
    }
    
    private func updateNavigationItem(vc: UIViewController) {
        switch vc {
        case is HomeViewController:
            
            let titleConfig = CustomBarItemConfiguration(
                title: "정자동",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let searchConfig = CustomBarItemConfiguration(
                title: nil,
                image: UIImage(systemName: "magnifyingglass"),
                handler: {print("search view")}
            )
            let searchItem = UIBarButtonItem.generate(
                with: searchConfig,
                width: 30
            )
        
            let feedConfig = CustomBarItemConfiguration(
                title: nil,
                image: UIImage(systemName: "bell"),
                handler: {print("feed view")}
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem, searchItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyTownViewController:
            
            let titleConfig = CustomBarItemConfiguration(
                title: "정자동",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
        
            let feedConfig = CustomBarItemConfiguration(
                title: nil,
                image: UIImage(systemName: "bell"),
                handler: {print("feed view")}
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is ChatViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "채팅",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
        
            let feedConfig = CustomBarItemConfiguration(
                title: nil,
                image: UIImage(systemName: "bell"),
                handler: {print("feed view")}
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig)
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyProfileViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "나의 당근",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
        
            let settingConfig = CustomBarItemConfiguration(
                title: nil,
                image: UIImage(systemName: "gearshape"),
                handler: {print("setting view")}
            )
            let settingItem = UIBarButtonItem.generate(with: settingConfig)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [settingItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        default:
            let titleConfig = CustomBarItemConfiguration(
                title: "정자동",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
        
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = []
            navigationItem.backButtonDisplayMode = .minimal
        }
    }
}

// [] 각 탭에 맞게 네비게이션 바 아이템 구성
// - 홈: 타이틀, 피드, 서치
// - 동네활동: 타이틀, 피드
// - 내 근처: 타이틀
// - 채팅: 타이틀 피드
// - 나의 당글 : 타이틀 설정

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigationItem(vc: viewController)
    }
}
