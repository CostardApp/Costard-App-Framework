//
//  ViewController.swift
//  TestFramework
//
//  Created by Brian Costard on 01/05/2018.
//  Copyright © 2018 Brian Costard. All rights reserved.
//

import UIKit
import CostardApp

class ViewController: UIViewController, YouTubeParserDelegate, CheckAppInstallDelegate {
    
    @IBOutlet weak var titleLabelVideo: UILabel!
    @IBOutlet weak var thumbnailImageViewVideo: UIImageView!
    
    @IBOutlet weak var titleLabelChannel: UILabel!
    @IBOutlet weak var viewCountLabelChannel: UILabel!
    @IBOutlet weak var videoCountLabelChannel: UILabel!
    @IBOutlet weak var subscriberCountLabelChannel: UILabel!
    @IBOutlet weak var thumbnailImageViewChannel: UIImageView!
    
    @IBOutlet weak var titleLabelPlaylist: UILabel!
    @IBOutlet weak var idLabelPlaylist: UILabel!
    @IBOutlet weak var itemCountLabelPlaylist: UILabel!
    @IBOutlet weak var thumbnailImageViewPlaylist: UIImageView!
    
    @IBOutlet weak var loadActivityIndicatorViewVideo: UIActivityIndicatorView!
    @IBOutlet weak var loadActivityIndicatorViewChannel: UIActivityIndicatorView!
    @IBOutlet weak var loadActivityIndicatorViewPlaylist: UIActivityIndicatorView!
    
    let YouTubeApiKey = "AIzaSyBW-WvvXy09iSE4Rx8sebM2MYkumt6jKUk"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivityIndicatorViewVideo.isHidden = false
        loadActivityIndicatorViewChannel.isHidden = false
        titleLabelVideo.isHidden = true
        thumbnailImageViewVideo.isHidden = true
        
        titleLabelChannel.isHidden = true
        viewCountLabelChannel.isHidden = true
        videoCountLabelChannel.isHidden = true
        subscriberCountLabelChannel.isHidden = true
        thumbnailImageViewChannel.isHidden = true
        
        titleLabelPlaylist.isHidden = true
        idLabelPlaylist.isHidden = true
        itemCountLabelPlaylist.isHidden = true
        thumbnailImageViewPlaylist.isHidden = true
        
        YouTubeParser.delegateYouTubeParser = self
        CheckAppInstall.delegateCheckAppInstall = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        YouTubeParser.loadVideosFromPlaylist(YouTubeApiKey: YouTubeApiKey, PlaylistID: "UUhi_U5HDWUfudfl8KKfuWvg", maxResults: "1")
        
        YouTubeParser.loadStatisticsChannel(YouTubeApiKey: YouTubeApiKey, ChannelID: "UChi_U5HDWUfudfl8KKfuWvg")
        
        YouTubeParser.loadPlaylist(YouTubeApiKey: YouTubeApiKey, ChannelID: "UCyMy3i-BaVOmOwTZskm52Ew")
        
        CheckAppInstall.checkAppInstallWithURLScheme(appURLScheme: "UnwinTLSCostardApp://")
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
        
        loadActivityIndicatorViewChannel.isHidden = true
        titleLabelChannel.isHidden = false
        viewCountLabelChannel.isHidden = false
        videoCountLabelChannel.isHidden = false
        subscriberCountLabelChannel.isHidden = false
        thumbnailImageViewChannel.isHidden = false
    }
    
    func appIsNotInstalled() {}
    
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
        
        loadActivityIndicatorViewVideo.isHidden = true
        titleLabelVideo.isHidden = false
        thumbnailImageViewVideo.isHidden = false
        
    }
    
    func loadPlaylistFinish() {
        titleLabelPlaylist.text = YouTubeParser.titlePlaylist(Index: 0)
        itemCountLabelPlaylist.text = "\(YouTubeParser.itemCountPlaylist(Index: 0)) vidéos"
        idLabelPlaylist.text = YouTubeParser.idPlaylist(Index: 0)
        let imageUrl:URL = URL(string: YouTubeParser.thumbnailPlaylist(Index: 0))!
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.thumbnailImageViewPlaylist.image = image
                self.thumbnailImageViewPlaylist.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        titleLabelPlaylist.isHidden = false
        idLabelPlaylist.isHidden = false
        itemCountLabelPlaylist.isHidden = false
        thumbnailImageViewPlaylist.isHidden = false
    }
}

