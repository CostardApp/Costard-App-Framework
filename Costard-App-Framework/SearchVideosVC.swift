//
//  SearchVideosVC.swift
//  Costard-App-Framework
//
//  Created by Brian Costard on 01/06/2018.
//  Copyright © 2018 Brian Costard. All rights reserved.
//

import UIKit
import CostardApp

class SearchVideosVC: UIViewController, YouTubeParserDelegate {
    
    @IBOutlet weak var titleVideoLabelSearchVideos: UILabel!
    @IBOutlet weak var titleChannelLabelSearchVideos: UILabel!
    @IBOutlet weak var thumbnailImageViewSearchVideos: UIImageView!
    @IBOutlet weak var idVideoLabelSearchVideos: UILabel!
    @IBOutlet weak var loadActivityIndicatorViewSearchVideos: UIActivityIndicatorView!
    
    let YouTubeApiKey = "AIzaSyBW-WvvXy09iSE4Rx8sebM2MYkumt6jKUk"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chargment..."
        loadActivityIndicatorViewSearchVideos.isHidden = false
        titleVideoLabelSearchVideos.isHidden = true
        titleChannelLabelSearchVideos.isHidden = true
        thumbnailImageViewSearchVideos.isHidden = true
        idVideoLabelSearchVideos.isHidden = true

        YouTubeParser.delegateYouTubeParser = self
        YouTubeParser.searchVideos(YouTubeApiKey: YouTubeApiKey, Tags: "lasalle, gta, charlie", maxResults: 1)
    }
    
    func searchVideosFinish() {
        titleVideoLabelSearchVideos.text = YouTubeParser.titleVideoSearchVideo(Index: 0)
        titleChannelLabelSearchVideos.text = YouTubeParser.titleChannelSearchVideo(Index: 0)
        idVideoLabelSearchVideos.text = YouTubeParser.idVideoSearchVideo(Index: 0)
        let imageUrl:URL = URL(string: YouTubeParser.thumbnailSearchVideo(Index: 0))!
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.thumbnailImageViewSearchVideos.image = image
                self.thumbnailImageViewSearchVideos.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        self.navigationItem.title = "Search videos"
        loadActivityIndicatorViewSearchVideos.isHidden = true
        titleVideoLabelSearchVideos.isHidden = false
        titleChannelLabelSearchVideos.isHidden = false
        thumbnailImageViewSearchVideos.isHidden = false
        idVideoLabelSearchVideos.isHidden = false
    }
    
    func searchVideosError() {}
}

