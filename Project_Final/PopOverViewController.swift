//
//  popOverViewController.swift
//  ProjectTwo
//
//  Created by Vineeth Xavier on 10/27/17.
//  Copyright © 2017 Vineeth Xavier. All rights reserved.
//

import UIKit
import YouTubePlayer
class popOverViewController: UIViewController,YouTubePlayerDelegate {
    
    var videoId:String?
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayer.delegate = self
        if let vidId = videoId {
            self.view.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.30, alpha: 0.15)
            //autoplay and play with in size(not full screen
            videoPlayer.playerVars = ["autoplay":"0" as AnyObject, "playsinline": "1" as AnyObject]
            videoPlayer.loadVideoID(vidId)
        }
    }//viewDidLoad
    
   override func viewDidAppear(_ animated: Bool) {
    if videoPlayer.ready {
        playerReady(videoPlayer)
        }
    }//viewDidAppear
    
    func playerReady(_ videoPlayerParam: YouTubePlayerView) {
        print("====plyer ready==========")
        videoPlayerParam.play()
        //videoPlayer.play() // this also works
    }  
}//popOverViewController


