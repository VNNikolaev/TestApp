//
//  SceneDelegate.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let networkFacade = NetworkFacade()
        window?.rootViewController = UINavigationController(rootViewController: MainViewController(networkFacade: networkFacade))
        window?.makeKeyAndVisible()
    }
}

