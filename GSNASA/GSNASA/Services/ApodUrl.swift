//
//  ApiEndpoints.swift
//  GSNASA
//
//  Created by Yogesh2 Gupta on 23/07/22.
//

import Foundation

struct ApiEndpoints {
    
    let apodURL: String
    
    init(date:String) {
        self.apodURL = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&date=\(date)"
    }
    
}
