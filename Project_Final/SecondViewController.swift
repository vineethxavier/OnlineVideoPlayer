//
//  ViewController.swift
//  ProjectTwo
//
//  Created by Vineeth Xavier on 10/26/17.
//  Copyright © 2017 Vineeth Xavier. All rights reserved.
//
//AIzaSyDtV7aOWU_pgdAl6MM4ndOOsOgvdMQbFKM
import UIKit
import Alamofire
import RealmSwift // DB
import SVProgressHUD // loading progress
import GoogleSignIn
import SwiftyJSON
import AVKit
import AVFoundation
import YouTubePlayer

//var SearchResult: Results<Search>!
//var realm = try! Realm()




extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
  /*  ---------------------- Decoding JSON  ----------------------  */
struct responsee:Decodable
{
    let items:[items]
}
struct items:Decodable
{
    let etag:String
    let snippet:snippet
    let id:id
}

struct id:Decodable
{
    let videoId:String
}
struct snippet:Decodable
{
    let title:String
    let description:String
    let thumbnails:thumbnails
}
struct thumbnails:Decodable {
    let high:high
}
struct high:Decodable {
    let url:String
}
/*  ---------------------- End of Decoding JSON  ----------------------  */


/*  ---------------------- Initializing Array  ----------------------  */
var vidTitleArr =  [String]()
var vidIDArr =  [String]()
var vidImgUrlArr =  [String]()
var vidDescrArr = [String]()
var urlSearchVal:String? = "swift"
var imag = [UIImage]()


/*  ---------------------- View controller Class  ----------------------  */

class SecondViewController: UIViewController,UISearchBarDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
/*  ---------------------- Start of Collection View ----------------------  */
    
    @IBOutlet weak var VideoViewCollection: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return vidTitleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
       
    
         cell.TitleLabel?.text = vidTitleArr[indexPath.row]
        let imgURL = URL(string: vidImgUrlArr[indexPath.row])

                if imgURL != nil {
                    do{
                        let data = try Data.init(contentsOf: imgURL!)
                        cell.imageView?.image = UIImage.init(data: data)
                        imag.append(UIImage.init(data: data)!)
                    }
                    catch let error {
                        print(error)
                    }
                } else{
                    cell.imageView?.image = nil
                }

        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: BaseRoundedCardCell.cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"104") as! popOverViewController
        self.present(viewController, animated: true)
        
        //let video = "https://www.youtube.com/watch?v=\(vidIDArr[indexPath.row])"
        //let url = URL(string: video)
        //viewController.player = AVPlayer(url: url!)
        //viewController.player?.play()
    }

    /*  ---------------------- End of Collection View ----------------------  */
    
    
    @IBOutlet weak var searchVidField: UISearchBar!
    
    
     /*  ---------------------- Alamofire ----------------------  */
    func getVideoData(){
        let UrlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(urlSearchVal!.trimmingCharacters(in: .whitespacesAndNewlines))&key=AIzaSyDtV7aOWU_pgdAl6MM4ndOOsOgvdMQbFKM&type=video"
        
        let parameters: Parameters = ["items": [items]()]
        
        Alamofire.request(UrlString, method: .get,parameters: parameters).responseJSON{
            response in
            
            if response.result.isSuccess{
                let videoJSON: JSON = JSON(response.result.value!)
                self.updateVideo(json: videoJSON)

                self.VideoViewCollection.reloadData() // Reloading the Collection View
                
            }else{
                print("Error")
            }
            
        }
    }
     /*  ---------------------- End of Alamofire ----------------------  */
     /*  ---------------------- SwiftyJSON  ----------------------  */

    func updateVideo(json: JSON){
        
        for i in 0...4{

            let title = String(describing: json["items"][i]["snippet"]["title"])
            vidTitleArr.append(title)
            
            vidIDArr.append(String(describing: json["items"][i]["id"]["videoId"]))
            
            vidImgUrlArr.append(String(describing: json["items"][i]["snippet"]["thumbnails"]["high"]["url"]))
           
            
            vidDescrArr.append(String( describing: json["items"][i]["snippet"]["description"]))
        }
    }
    
     /*  ---------------------- End of SwiftyJSON  ----------------------  */
    
   
    
    @IBAction func searchVidBtn(_ sender: UIButton){
        vidTitleArr.removeAll()
        vidIDArr.removeAll()
        vidImgUrlArr.removeAll()
        vidDescrArr.removeAll()
        urlSearchVal = searchVidField.text
        viewDidLoad()
        VideoViewCollection.reloadData()
        getVideoData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchVidField.delegate = self
        self.hideKeyboardWhenTappedAround()
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
//       Registering nib file for collection View
        
        VideoViewCollection.register(UINib(nibName: "VideoCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }// mem warmning
    
    func searchBar(_ searchVidField: UISearchBar, textDidChange searchVal: String) {
        urlSearchVal = searchVal
    }
}

/*  ---------------------- End of View Controller Class  ----------------------  */

// Realm Object

//class Search: Object {
//     @objc dynamic var titles = ""
//}


