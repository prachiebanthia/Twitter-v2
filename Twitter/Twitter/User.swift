//
//  User.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/1/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var backgroundUrl: URL?
    var tagline: String?
    var numTweets: Int?
    var numFollowers: Int?
    var numFollowing: Int?
    
    var dictionary: NSDictionary?
    static let logoutNotificationName = NSNotification.Name(rawValue: "UserDidLogout")
    
    
    init(dictionary: NSDictionary){
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        numTweets = dictionary["statuses_count"] as? Int
        numFollowers = dictionary["followers_count"] as? Int
        numFollowing = dictionary["friends_count"] as? Int
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = URL(string: profileUrlString)
        }
        
        let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundUrlString = backgroundUrlString{
            backgroundUrl = URL(string: backgroundUrlString)
        }
        
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
            
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set (user) {
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }

            defaults.synchronize()
        }
    }
    
}
