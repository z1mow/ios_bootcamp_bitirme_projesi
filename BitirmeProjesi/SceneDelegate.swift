//
//  SceneDelegate.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 28.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        
        let urunlerVC = UrunListesiViewController(sadeceFavoriler: false)
        let urunlerNav = UINavigationController(rootViewController: urunlerVC)
        urunlerVC.title = "Ürünler"
        urunlerNav.tabBarItem = UITabBarItem(
            title: "Ürünler",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let favorilerVC = UrunListesiViewController(sadeceFavoriler: true)
        let favorilerNav = UINavigationController(rootViewController: favorilerVC)
        favorilerVC.title = "Favorilerim"
        favorilerNav.tabBarItem = UITabBarItem(
            title: "Favorilerim",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        let sepetVC = SepetViewController()
        let sepetNav = UINavigationController(rootViewController: sepetVC)
        sepetVC.title = "Sepetim"
        sepetNav.tabBarItem = UITabBarItem(
            title: "Sepetim",
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill")
        )
        
        tabBarController.viewControllers = [urunlerNav, favorilerNav, sepetNav]
        
        tabBarController.tabBar.tintColor = UIColor.systemBlue
        tabBarController.tabBar.backgroundColor = UIColor.white
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

