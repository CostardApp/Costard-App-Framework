//
//  ViewController.swift
//  TestFramework
//
//  Created by Brian Costard on 01/05/2018.
//  Copyright © 2018 Brian Costard. All rights reserved.
//

import UIKit
import CostardApp

class LoadVideosFromPlaylistVC: UIViewController, YouTubeParserDelegate {
    
    @IBOutlet weak var titleLabelVideo: UILabel!
    @IBOutlet weak var thumbnailImageViewVideo: UIImageView!
    @IBOutlet weak var loadActivityIndicatorViewVideo: UIActivityIndicatorView!
    
    let YouTubeApiKey = "AIzaSyBW-WvvXy09iSE4Rx8sebM2MYkumt6jKUk"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chargement..."
        loadActivityIndicatorViewVideo.isHidden = false
        titleLabelVideo.isHidden = true
        thumbnailImageViewVideo.isHidden = true
        
        YouTubeParser.delegateYouTubeParser = self
        YouTubeParser.loadVideosFromPlaylist(YouTubeApiKey: YouTubeApiKey, PlaylistID: "UUhi_U5HDWUfudfl8KKfuWvg", maxResults: 1)
    }
    
    func loadVideosFinish() {
        titleLabelVideo.text = YouTubeParser.titleVideo(Index: 0)
        let imageUrl:URL = URL(string: YouTubeParser.thumbnailVideo(Index: 0))!
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.thumbnailImageViewVideo.image = image
                self.thumbnailImageViewVideo.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        self.navigationItem.title = "Load videos from playlist"
        loadActivityIndicatorViewVideo.isHidden = true
        titleLabelVideo.isHidden = false
        thumbnailImageViewVideo.isHidden = false
    }
    
    func loadVideosError() {}
}

