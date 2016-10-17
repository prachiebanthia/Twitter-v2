//
//  MovieInfo.swift
//  Flicks
//  This class simply holds Movie data for easy access
//

import UIKit

class MovieData: NSObject {
    var poster_path: String? = nil
    var overview: String? = nil
    var original_title: String? = nil
    var title: String? = nil
    
    init(movie: NSDictionary) {
        self.poster_path = movie.value(forKey: "poster_path") as? String
        self.overview = movie.value(forKey: "overview") as? String
        self.original_title = movie.value(forKey: "original_title") as? String
        self.title = movie.value(forKey: "title") as? String
    }
}
