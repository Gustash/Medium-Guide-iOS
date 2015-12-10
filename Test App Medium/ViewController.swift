import UIKit
import Parse

class ViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = PFUser()
        
        user.username = "my name"
        
        user.password = "my pass"
        
        user.email = "email@example.com"
        
        // other fields can be set if you want to save more information
        
        user["phone"] = "650–555–0000"
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if error == nil {
                
                // Hooray! Let them use the app now.
                
            } else {
                
                // Examine the error object and inform the user.
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func subscribeButtonClick(sender: AnyObject) {
        subscribeChannel("general")
    }
    
    
    @IBAction func messageButtonClick(sender: AnyObject) {
        sendMessage("general", message: "Hello World!")
    }
    
    func subscribeChannel(channel: String) {
        if (appDelegate.ortc?.isConnected() == true) {
            appDelegate.ortc?.subscribe(channel)
        } else {
            print("Ortc not connected yet.")
        }
    }
    
    func sendMessage(channel: String, message: String) {
        if (appDelegate.ortc?.isConnected() == true) {
            appDelegate.ortc?.send(channel, message: message)
        } else {
            print("Ortc not connected yet.")
        }
    }


}

