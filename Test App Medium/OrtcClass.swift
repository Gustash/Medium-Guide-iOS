import UIKit

class OrtcClass: NSObject, OrtcClientDelegate{
    let APPKEY = "YOUR_APP_KEY"
    let TOKEN = "TOKEN"
    let METADATA = "METADATA"
    let URL = "https://ortc-developers.realtime.co/server/ssl/2.1/"
    
    var ortc: OrtcClient?
    var onMessage:AnyObject?
    
    func connect()
    {
        self.ortc = OrtcClient.ortcClientWithConfig(self) as? OrtcClient
        self.ortc!.connectionMetadata = METADATA
        self.ortc!.clusterUrl = URL
        
        self.ortc!.connect(APPKEY, authenticationToken: TOKEN)
    }
    
    
    func onConnected(ortc: OrtcClient!) {
        NSLog("CONNECTED")
        NSNotificationCenter.defaultCenter().postNotificationName("ortcConnect", object: nil)

    }
    
    func onSubscribed(ortc: OrtcClient!, channel: String!) {
        NSLog("did subscribe %@", channel)
    }
    
    func onUnsubscribed(ortc: OrtcClient!, channel: String!) {
        
    }
    
    
    func onDisconnected(ortc: OrtcClient!) {
        
    }
    
    func onException(ortc: OrtcClient!, error: NSError!) {
        
        let desc:String = (error.userInfo as NSDictionary).objectForKey("NSLocalizedDescription") as! String
        if desc == "Unable to get URL from cluster (http://ortc-developers.realtime.co/server/2.1/)" || desc == "Unable to get URL from cluster (https://ortc-developers.realtime.co/server/ssl/2.1/)"
        {
            NSNotificationCenter.defaultCenter().postNotificationName("noConnection", object: nil)
        }
        NSLog("%@", desc)
    }
    
    func onReconnected(ortc: OrtcClient!) {
        NSNotificationCenter.defaultCenter().postNotificationName("ortcConnect", object: nil)
    }
    
    func onReconnecting(ortc: OrtcClient!) {
        
    }

    func subscribe(channel: String) {
        self.ortc!.subscribeWithNotifications(channel, subscribeOnReconnected: true, onMessage: {
            (ortcClient:OrtcClient!, channel:String!, message:String!) -> Void in
            
            NSLog("New message on channel %@: %@", channel, message)
            
        })
    }
    
    func send(channel: String, message: String) {
        self.ortc!.send(channel, message: message)
    }
    
    func isConnected() -> Bool {
        return self.ortc!.isConnected
    }
    
}
