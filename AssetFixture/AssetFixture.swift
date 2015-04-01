//
//  AssetFixture.swift
//  AssetFixture
//
//  Created by Julien Chaumond on 01/04/2015.
//  Copyright (c) 2015 Julien Chaumond. All rights reserved.
//

import UIKit
import AssetsLibrary

class AssetFixture {
    
    let urls = [
        "https://unsplash.imgix.net/photo-1426200830301-372615e4ac54?fit=crop&fm=jpg&h=725&q=75&w=1050",
        "https://ununsplash.imgix.net/photo-1423483641154-5411ec9c0ddf?fit=crop&fm=jpg&h=700&q=75&w=1050",
        "https://unsplash.imgix.net/photo-1422310299561-e3b8b45d859f?fit=crop&fm=jpg&h=700&q=75&w=1050",
        "https://unsplash.imgix.net/photo-1421977870504-378093748ae6?fit=crop&fm=jpg&h=700&q=75&w=1050",
        "https://ununsplash.imgix.net/photo-1421940975339-33bdde74a873?fit=crop&fm=jpg&h=800&q=75&w=1050",
        "https://unsplash.imgix.net/photo-1421930451953-73c5c9ae9abf?fit=crop&fm=jpg&h=725&q=75&w=1050",
        "https://unsplash.imgix.net/photo-1421809313281-48f03fa45e9f?fit=crop&fm=jpg&h=750&q=75&w=1050",
        "https://ununsplash.imgix.net/photo-1421757295538-9c80958e75b0?fit=crop&fm=jpg&h=700&q=75&w=1050",
        "https://ununsplash.imgix.net/photo-1421091242698-34f6ad7fc088?fit=crop&fm=jpg&h=725&q=75&w=1050",
        "https://unsplash.imgix.net/photo-1420745981456-b95fe23f5753?fit=crop&fm=jpg&h=700&q=75&w=1050",
    ]
    
    var images = [UIImage]()
    
    let library = ALAssetsLibrary()
    let albumName = "Fixtures"
    var assetUrls = [NSURL]()
    
    
    func loadImages() -> AssetFixture {
        for u in urls {
            let data = NSData(contentsOfURL: NSURL(string: u)!)
            if let data = data {
                let image = UIImage(data: data)
                if let image = image {
                    images.append(image)
                }
            }
            else {
                println("Failed fetching url: \(u)")
            }
        }
        return self
    }
    
    func loadSavedPhotos(#iterations: Int) -> Bool {
        if images.count == 0 {
            return false
        }
        for _ in 1...iterations {
            for image in images {
                library.writeImageToSavedPhotosAlbum(image.CGImage, orientation: ALAssetOrientation.Up, completionBlock: { (assetURL, error) -> Void in
                    if error != nil {
                        println(error)
                        return
                    }
                    println(assetURL)
                    self.assetUrls.append(assetURL)
                })
            }
        }
        return true
    }
    
    
    
    func ensureAlbum(completion: (ALAssetsGroup?, NSError?) -> Void) {
        var hasFound = false
        library.enumerateGroupsWithTypes(ALAssetsGroupAlbum, usingBlock: { (group, stop) -> Void in
            if group == nil {
                if !hasFound {
                    // Enumeration is done: we haven't found our album. So let's create it.
                    self.createAlbum(completion)
                }
                return
            }
            else {
                if (group.valueForProperty("ALAssetsGroupPropertyName") as NSString == self.albumName) && group.editable {
                    // The album name is not unique, but this album is editable, so it must be ours.
                    // We should also stop iterating, but I don't know how to do this in Swift :/
                    // stop = true
                    // stop.memory = true
                    if !hasFound {
                        hasFound = true
                        return completion(group, nil)
                    }
                }
            }
        }) { (error) -> Void in
            return completion(nil, error)
        }
    }
    
    private func createAlbum(completion: (ALAssetsGroup?, NSError?) -> Void) {
        library.addAssetsGroupAlbumWithName(albumName, resultBlock: { (group) -> Void in
            assert(group != nil, "If nil here, it means the album already existed.")
            return completion(group, nil)
        }) { (error) -> Void in
            return completion(nil, error)
        }
    }
    
    
    func loadAlbum(#iterations: Int) -> (ALAssetsGroup -> Void) {
        return { (group: ALAssetsGroup) -> Void in
            for _ in 1...iterations {
                println(self.assetUrls.count)
                for u in self.assetUrls {
                    self.library.assetForURL(u, resultBlock: { (asset) -> Void in
                        group.addAsset(asset)
                        return
                    }, failureBlock: { (error) -> Void in
                        println(error)
                    })
                }
            }
        }
    }
}


