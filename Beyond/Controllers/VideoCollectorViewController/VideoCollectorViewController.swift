//
//  VideoCollectorViewController.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import UIKit
import AVFoundation

class VideoCollectorViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var playerAV: AVPlayer!
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
 

      
     
    
    
    @IBAction func ChooseVideoAction(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image", "public.movie"]
        present(imagePickerController, animated: true, completion: nil)
   
    }

    @objc func animationDidFinish(_ notification: NSNotification) {
            playerAV.seek(to: .zero)
            playerAV.play()
            playerAV.pause()
            print(#function)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        videoURL = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerReferenceURL")] as? URL
        self.playvideo(videourl: videoURL?.absoluteString ?? "") 
        print(videoURL)
        imagePickerController.dismiss(animated: true, completion: nil)
    }
   
}


extension VideoCollectorViewController{
    
    
    
    func playvideo(videourl: String) {
        
        guard let firstVideo = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("Video not found")
            return
        }
        print(videourl)
        if videourl == nil{
            playerAV = AVPlayer(url: URL(fileURLWithPath: firstVideo))
        }else{
            let videoURL = URL(string: videourl)
            playerAV = AVPlayer(url: videoURL!)
        }
        
        let playerLayerAV = AVPlayerLayer(player: playerAV)
        playerLayerAV.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayerAV)
        playerLayerAV.videoGravity = .resizeAspectFill
        playerAV.play()
        
        // you can fatch when video ended
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(animationDidFinish(_:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: playerAV.currentItem)
        
    }
}
    
extension VideoCollectorViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}
