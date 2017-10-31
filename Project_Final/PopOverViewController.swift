//
//  popOverViewController.swift
//  ProjectTwo
//
//  Created by Vineeth Xavier on 10/27/17.
//  Copyright © 2017 Vineeth Xavier. All rights reserved.
//

import UIKit

class popOverViewController: UIViewController {
    var vidTitle:String?
    var vidUrl:String?
    var vidId:String?
    
    @IBOutlet weak var videoTitleLbl: UILabel!
    @IBOutlet weak var videoUrlLbl: UILabel!
    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let titleVal = vidTitle
        {
            videoTitleLbl.text = titleVal
        }
        if let imgUrlVal = vidUrl{
            videoUrlLbl.text = imgUrlVal
        }
        if let idVal = vidId{
            getVideo(videoCode: idVal)
        }
        
        
        
    }//viewDidLoad
    @IBAction func cancelAction(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }//cancelAction
    
    func getVideo(videoCode:String)
    {
        let selectedVideoUrl = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        myWebView.loadRequest(URLRequest(url: selectedVideoUrl!))
    }//func get video
    
}//popOverViewController

