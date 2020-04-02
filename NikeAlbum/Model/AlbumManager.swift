//
//  AlbumManager.swift
//  NikeAlbum
//
//  Created by sahin raj on 2/19/20.
//  Copyright © 2020 sahin raj. All rights reserved.
//

import Foundation
import UIKit

protocol AlbumManagerDelegate {
    func didUpdateAlbumData(albumManager: AlbumManager, albumData: Album)
}

struct AlbumManager {
    
    let albumURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/new-releases/all/100/explicit.json"
    var delegate: AlbumManagerDelegate?
    
    //MARK: - Fetch data from server with API
    func fetchAlbumDetails (rawURL:String) -> Bool{
        
        //1. Create a URL
        if let url = URL(string: albumURL) {
            //2. Create URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give Session a Task
            let task = session.dataTask(with: url, completionHandler: handleTaskData(data:urlResponse:error:))
            //4. Start the Task
            task.resume()
            return true
            
        } else {
            
            print("Error in AlbumManager -> fetchAlbumDetails Method")
            return false
        }
        
    }
    
    //MARK: - Session task handler
    
    func handleTaskData(data: Data?, urlResponse: URLResponse?, error: Error?) {
        
        if error != nil {
            print("Error in AlbumManager -> handleTaskData Method ")
            return
        }
        
        if let safeData = data {
            if let temp = self.parseJSON(albumData: safeData) {
                DispatchQueue.main.async {
                    self.delegate?.didUpdateAlbumData(albumManager: self, albumData: temp)
                }
            }
        }
        
    }
    
    //MARK: - JSON parse to Model
    
    func parseJSON(albumData: Data) -> Album? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Album.self, from: albumData)
            return decodedData
            
        } catch  {
            print("Error in AlbumManager -> parseJSON")
            return nil
        }
        
    }
    
    
}
