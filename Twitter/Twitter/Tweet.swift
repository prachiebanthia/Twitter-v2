//
//  Tweet.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/1/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var texto: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favCount: Int = 0
    
    //date formatting
    var timeSinceCreated: String? {
        get {
            if timestamp == nil {
                return nil
            }
            let now = Date()
            let seconds = Calendar.current.dateComponents([Calendar.Component.second], from: timestamp!, to: now).second ?? 0
            if seconds < 60 {
                return "\(seconds)s"
            }
            let minutes = Calendar.current.dateComponents([Calendar.Component.minute], from: timestamp!, to: now).minute ?? 0
            if minutes < 60 {
                return "\(minutes)m"
            }
            let hours = Calendar.current.dateComponents([Calendar.Component.hour], from: timestamp!, to: now).hour ?? 0
            if hours < 24 {
                return "\(hours)h"
            }
            let days = Calendar.current.dateComponents([Calendar.Component.day], from: timestamp!, to: now).day ?? 0
            return "\(days)d"
        }
    }
    
    var formattedTime: String? {
        get {
            if timestamp == nil {
                return nil
            }
            let formatter = DateFormatter()
            return formatter.string(from: timestamp!)
        }
    }
    
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        texto = dictionary["text"] as? String
        let timestampStr = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formatter.date(from: timestampStr!) as Date?
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favCount = (dictionary["favorite_count"] as? Int) ?? 0
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}


