//
//  CheckAppInstallVC.swift
//  Costard-App-Framework
//
//  Created by Brian Costard on 01/06/2018.
//  Copyright © 2018 Brian Costard. All rights reserved.
//

import UIKit
import CostardApp

class CheckAppInstallVC: UIViewController, CheckAppInstallDelegate {

    @IBOutlet weak var checkAppInstallLabel: UILabel!
    @IBOutlet weak var loadActivityIndicatorViewCheckAppInstall: UIActivityIndicatorView!
    
    let YouTubeApiKey = "AIzaSyBW-WvvXy09iSE4Rx8sebM2MYkumt6jKUk"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Chargement..."
        checkAppInstallLabel.isHidden = true
        loadActivityIndicatorViewCheckAppInstall.isHidden = false
        CheckAppInstall.delegateCheckAppInstall = self
        
        CheckAppInstall.checkAppInstallWithURLScheme(appURLScheme: "youtube://", withOpenApp: false)
    }
    
    func appIsInstalled() {
        self.navigationItem.title = "Check app install"
        loadActivityIndicatorViewCheckAppInstall.isHidden = true
        checkAppInstallLabel.text = "App is installed!"
        checkAppInstallLabel.isHidden = false
    }
    
    func appIsNotInstalled() {
        self.navigationItem.title = "Check app install"
        loadActivityIndicatorViewCheckAppInstall.isHidden = true
        checkAppInstallLabel.text = "App is not installed!"
        checkAppInstallLabel.isHidden = false
    }
}

