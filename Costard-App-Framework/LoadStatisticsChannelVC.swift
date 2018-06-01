//
//  LoadStatisticsChannelVC.swift
//  Costard-App-Framework
//
//  Created by Brian Costard on 01/06/2018.
//  Copyright © 2018 Brian Costard. All rights reserved.
//

import UIKit
import CostardApp

class LoadStatisticsChannelVC: UIViewController, YouTubeParserDelegate {
    
    @IBOutlet weak var titleLabelChannel: UILabel!
    @IBOutlet weak var viewCountLabelChannel: UILabel!
    @IBOutlet weak var videoCountLabelChannel: UILabel!
    @IBOutlet weak var subscriberCountLabelChannel: UILabel!
    @IBOutlet weak var thumbnailImageViewChannel: UIImageView!
    @IBOutlet weak var loadActivityIndicatorViewChannel: UIActivityIndicatorView!
    
    let YouTubeApiKey = "AIzaSyBW-WvvXy09iSE4Rx8sebM2MYkumt6jKUk"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chargement..."
        loadActivityIndicatorViewChannel.isHidden = false
        titleLabelChannel.isHidden = true
        viewCountLabelChannel.isHidden = true
        videoCountLabelChannel.isHidden = true
        subscriberCountLabelChannel.isHidden = true
        thumbnailImageViewChannel.isHidden = true
        
        YouTubeParser.delegateYouTubeParser = self
        YouTubeParser.loadStatisticsChannel(YouTubeApiKey: YouTubeApiKey, ChannelID: "UChi_U5HDWUfudfl8KKfuWvg")
    }
    
    func loadStatisticsChannelFinish() {
        titleLabelChannel.text = YouTubeParser.titleChannel()
        viewCountLabelChannel.text = YouTubeParser.viewCountChannel() + " vues"
        videoCountLabelChannel.text = YouTubeParser.videoCountChannel() + " vidéos"
        subscriberCountLabelChannel.text = YouTubeParser.subscriberCountChannel() + " abonnés"
        let imageUrl:URL = URL(string: YouTubeParser.thumbnailChannel())!
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.thumbnailImageViewChannel.image = image
                self.thumbnailImageViewChannel.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        self.navigationItem.title = "Load statistics channel"
        loadActivityIndicatorViewChannel.isHidden = true
        titleLabelChannel.isHidden = false
        viewCountLabelChannel.isHidden = false
        videoCountLabelChannel.isHidden = false
        subscriberCountLabelChannel.isHidden = false
        thumbnailImageViewChannel.isHidden = false
    }
    
    func loadStatisticsChannelError() {}
}

