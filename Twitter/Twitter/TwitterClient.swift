//
//  TwitterClient.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/1/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "TUBon1bcamU4I24a75w0ZHN8r", consumerSecret: "HXXqwdfTASQfm01fLNQHvo6tMgbOI12fcWCSHv51SXmSIoCJZL")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error?) -> ())?
    
    //fetches home timeline
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response:Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })
    }
    
        func getAccount(success: @escaping (User) -> (), failure: @escaping (Error?) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            //rint("account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
    
            success(user)
            
            }, failure: { (task:URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    
    func login(success: (() -> ())?, failure: @escaping ((Error?) -> ())) {
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            let str = requestToken?.token
            let str2 = "https://api.twitter.com/oauth/authenticate?oauth_token=\(str!)"
            let url = URL(string: str2)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
            
            }, failure: { (error: Error?) in
                print(error?.localizedDescription)
                self.loginFailure?(error)
        })
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            NSLog("Access token: \(accessToken?.token)")
            
            self.getAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: Error?) in
                    self.loginFailure?(error)
            })
        }) { (error: Error?) in
            NSLog("Error: \(error?.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func tweet(status: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        var params = Dictionary<String, Any>()
        params["status"] = status
        
        post("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let theJson = response as! NSDictionary
            let newTweet = Tweet(dictionary: theJson)
            success(newTweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: User.logoutNotificationName, object: nil)
    }
}
