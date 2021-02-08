//
//  AppDelegate.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/1/21.
//


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
        } else {
            if
                let splitViewController = window?.rootViewController as? UISplitViewController,
                let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
                let masterViewController = leftNavController.viewControllers.first as? NewsViewController,
                let detailViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? DetailViewController {
                let firstNews = masterViewController.newsResponse?.first
                detailViewController.news = firstNews
                masterViewController.delegate = detailViewController
            }
        }
        return true
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
}

