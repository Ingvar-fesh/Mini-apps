import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConf = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConf.storyboard = nil
        sceneConf.sceneClass = UIWindowScene.self
        sceneConf.delegateClass = SceneDelegate.self
        
        return sceneConf
    }
}

