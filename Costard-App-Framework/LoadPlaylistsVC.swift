//
//  ViewController.swift
//  TestFramework
//
//  Created by Brian Costard on 01/05/2018.
//  Copyright © 2018 Brian Costard. All rights reserved.
//

import UIKit
import CostardApp

class LoadPlaylistsVC: UIViewController, YouTubeParserDelegate {
    
    @IBOutlet weak var titleLabelPlaylist: UILabel!
    @IBOutlet weak var idLabelPlaylist: UILabel!
    @IBOutlet weak var itemCountLabelPlaylist: UILabel!
    @IBOutlet weak var thumbnailImageViewPlaylist: UIImageView!
    @IBOutlet weak var loadActivityIndicatorViewPlaylist: UIActivityIndicatorView!
    
    let YouTubeApiKey = "AIzaSyBW-WvvXy09iSE4Rx8sebM2MYkumt6jKUk"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chargement..."
        loadActivityIndicatorViewPlaylist.isHidden = false
        titleLabelPlaylist.isHidden = true
        idLabelPlaylist.isHidden = true
        itemCountLabelPlaylist.isHidden = true
        thumbnailImageViewPlaylist.isHidden = true
        
        YouTubeParser.delegateYouTubeParser = self
        YouTubeParser.loadPlaylists(YouTubeApiKey: YouTubeApiKey, ChannelID: "UCyMy3i-BaVOmOwTZskm52Ew", maxResults: 1)
    }
    
    func loadPlaylistsFinish() {
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
        
        self.navigationItem.title = "Load playlists"
        loadActivityIndicatorViewPlaylist.isHidden = true
        titleLabelPlaylist.isHidden = false
        idLabelPlaylist.isHidden = false
        itemCountLabelPlaylist.isHidden = false
        thumbnailImageViewPlaylist.isHidden = false
    }
    
    func loadPlaylistsError() {}
}


