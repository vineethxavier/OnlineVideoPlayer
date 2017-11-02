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
    
    override func viewDidLoad(){
        super.viewDidLoad()
        if let vidId = videoId
        {
//            videoPlayer.loadVideoID(vidId)
//            if videoPlayer.ready{
//                videoPlayer.play()
//            }
             videoPlayer.loadVideoID(vidId)
            videoPlayer.play()
        }
        
        
    }//viewDidLoad
    
   override func viewDidAppear(_ animated: Bool) {
    if videoPlayer.ready{
        playerReady(videoPlayer)
        }
    }//viewDidAppear
    
    func playerReady(_ videoPlayerParam: YouTubePlayerView) {
        videoPlayer.play()
    }
}//popOverViewController

