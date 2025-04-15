//
//  SceneDelegate.swift
//  TodoApp
//
//  Created by Muhammet Yiğit on 15.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let splashVC = UIViewController()
        splashVC.view.backgroundColor = .black
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.alpha = 1
        
        splashVC.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: splashVC.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: splashVC.view.centerYAnchor)
        ])
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
        
        func typeWritingEffect() {
            let text = "Todo...✏️"
            titleLabel.text = ""
            
            for (index, letter) in text.enumerated() {
                let delay = Double(index) * 0.2
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    titleLabel.text?.append(letter)
                    
                    if index == 0 {
                        UIView.animate(withDuration: Double(text.count) * 0.15, delay: 0, options: [.curveEaseInOut], animations: {
                            splashVC.view.backgroundColor = .white
                            titleLabel.textColor = .darkGray
                        })
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            typeWritingEffect()
        }
        
        
        let totalDuration = Double("Todo...".count) * 0.15 + 0.5 + 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let nav = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController else { return }
            self.window?.rootViewController = nav
        }
    }
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




