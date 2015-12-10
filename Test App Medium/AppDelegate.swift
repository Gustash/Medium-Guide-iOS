import UIKit
import Parse

@UIApplicationMain
class AppDelegate: RealtimePushAppDelegate {
    var ortc: OrtcClass?
    var notifications:NSMutableDictionary = NSMutableDictionary()


    override func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ortc = OrtcClass()
        ortc?.connect()
        
        super.application(application, didFinishLaunchingWithOptions: launchOptions)

        // Override point for customization after application launch.
        Parse.setApplicationId("YOUR_APPLICATION_ID", clientKey: "YOUR_CLIENT_KEY")
        
        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge], categories: nil))
        }

        
        return true
    }
    
    override func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    override func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        super.application(application, didReceiveRemoteNotification: userInfo)
        var aps:NSDictionary? = userInfo as NSDictionary
        aps = aps?.objectForKey("aps") as? NSDictionary
        
        if aps != nil && application.applicationState != UIApplicationState.Active
        {
            let data:NSMutableDictionary = NSMutableDictionary()
            data.setObject(aps?.objectForKey("Type") as! String, forKey: "Type")
            data.setObject(aps?.objectForKey("Timestamp") as! String, forKey: "Timestamp")
            
            let type:String = aps?.objectForKey("Type") as! String
            let timestamp:String = aps?.objectForKey("Timestamp") as! String
            
            notifications.setObject(data, forKey: "\(type)-\(timestamp)")
            NSNotificationCenter.defaultCenter().postNotificationName("notification", object: nil)
        }
    }
    
    override func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Couldn't register: \(error)")
    }

    override func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   }

   override  func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    override func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    override func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    override func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

