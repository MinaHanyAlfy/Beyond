//
//  VideoCollectorViewController.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import UIKit
import AVFoundation
import AVKit

class VideoCollectorViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var player: AVPlayer!
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?{
        didSet{
            DispatchQueue.main.async {
                self.playVideo()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func vidoPickerSetup(){
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image", "public.movie"]
    }
     
    @IBAction func ChooseVideoAction(_ sender: Any) {
    
        //present(imagePickerController, animated: true, completion: nil)
        playVideo()
        
    }
}

//MARK: - UIImagePickerControllerDelegate
extension VideoCollectorViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        videoURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UINavigationControllerDelegate
extension VideoCollectorViewController: UINavigationControllerDelegate {
    
}

//MARK: - Play Video
extension VideoCollectorViewController {
    func playVideo() {
        guard let videoURL = URL(string: "https://www.youtube.com/watch?v=Edp_pbG_CPI") else { return }
        player = AVPlayer(url: videoURL)
        player = AVPlayer(url: videoURL as URL)
        player.actionAtItemEnd = .none
        player.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.videoGravity = AVLayerVideoGravity.resize
        playerLayer.zPosition = -1
        playerLayer.frame = mainView.layer.bounds
        
        
        mainView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        player.play()
        
        //loop video
        NotificationCenter.default.addObserver(self,
                                               selector: #selector
                                               (self.loopVideo),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
        
    }
    
    @objc func loopVideo() {
        player.seek(to: CMTime.zero)
        player.play()
    }
}

//MARK: - UICollectionViewDataSource
extension VideoCollectorViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deqeueReusableCell(collectionViewCell: FilterCollectionViewCell.self, indexPath: indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension VideoCollectorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

//MARK: - Thumbnail From Video
extension VideoCollectorViewController {
    public func imageFromVideo(url: URL, at time: TimeInterval, completion: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url)
            let assetIG = AVAssetImageGenerator(asset: asset)
            assetIG.appliesPreferredTrackTransform = true
            assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels
            let cmTime = CMTime(seconds: time, preferredTimescale: 60)
            let thumbnailImageRef: CGImage
            do {
                thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
            } catch let error {
                print("Error: \(error)")
                return completion(nil)
            }
            DispatchQueue.main.async {
                completion(UIImage(cgImage: thumbnailImageRef))
            }
        }
    }
    
}
