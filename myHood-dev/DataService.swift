//
//  DataService.swift
//  myHood-dev
//
//  Created by Eduardo Chiaro on 1/17/17.
//  Copyright © 2017 Eduardo Chiaro. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        let postData = NSKeyedArchiver.archivedData(withRootObject: _loadedPosts)
        UserDefaults.standard.set(postData, forKey: KEY_POSTS)
        UserDefaults.standard.synchronize()
    }
    func loadPosts() {
        if let postsData = UserDefaults.standard.object(forKey: KEY_POSTS) as? NSData {
            if let postsArray = NSKeyedUnarchiver.unarchiveObject(with: postsData as Data) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "postsLoaded")))
    }
    func saveImage(image: UIImage) -> String{
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(Date.timeIntervalSinceReferenceDate).png"
        let fullPath = documentsPath(named: imgPath)
        
        do {
            try imgData?.write(to: URL(fileURLWithPath: fullPath), options: .atomic)
        } catch {
            print(error)
        }
        
        return imgPath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPath(named: path)
        let image = UIImage(named: fullPath)
        return image
        
    }
    
    func addPost(post: Post){
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentsPath(named: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fullPath = paths[0] as NSString
        
        return fullPath.appendingPathComponent(named)
    }
}
