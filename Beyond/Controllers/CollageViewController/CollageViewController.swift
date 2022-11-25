//
//  CollageViewController.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import UIKit
import PhotosUI

class CollageViewController: UIViewController {

    @IBOutlet weak var collageDoubleView: CollageDoubleView!
    @IBOutlet weak var collageTripleView: CollageTripleView!
    
    private let imagePickerController = UIImagePickerController()
    private var firstImageView : UIImageView?
    private var secImageView: UIImageView?
    private var images: [UIImage] = []
    private var configuration = PHPickerConfiguration()
    private var picker : PHPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewsSetup()
    }
    
    private func viewsSetup() {
        collageDoubleView.isHidden = true
        collageTripleView.isHidden = true
    }
    private func phpPickerSetup(count: Int) {
        configuration.filter = .images
        picker = PHPickerViewController(configuration: configuration)
        picker!.delegate = self
    }
    
    @IBAction func chooseCollageAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Number of Image", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "2 Images", style: UIAlertAction.Style.default, handler: {  [self] action in
            configuration.selectionLimit = 2
            phpPickerSetup(count: 2)
            collageTripleView.isHidden = true
            collageDoubleView.isHidden = false
        }))
        alert.addAction(UIAlertAction(title: "3 Images", style: UIAlertAction.Style.default, handler: { [self] action in
            configuration.selectionLimit = 3
            phpPickerSetup(count: 3)
            collageDoubleView.isHidden = true
            collageTripleView.isHidden = false
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addImagesAction(_ sender: Any) {
        
        if collageDoubleView.isHidden && collageTripleView.isHidden {
            let alert = UIAlertController(title: "ALERT!", message: "Please, Choose collage first from + ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
        guard let picker = self.picker else{return}
        present(picker, animated: true)
    }
    
}

//MARK: - PHPickerViewControllerDelegate
extension CollageViewController: PHPickerViewControllerDelegate
{
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
        picker.dismiss(animated: true)
            if results.count > 1 {
                for i in 0..<results.count {
                    let secondItemProvider = results[i].itemProvider
                    if secondItemProvider.canLoadObject(ofClass: UIImage.self) {
                        secondItemProvider.loadObject(ofClass: UIImage.self) { [weak self]  image, error in
                            if let secondImage = image as? UIImage{
                                DispatchQueue.main.async {
                                    self?.images.append(secondImage)
                                    self?.setImages()
                                }
                            }
                        }
                    }
                }
                
            }
    }
}

//MARK: -  UINavigationControllerDelegate
extension CollageViewController:  UINavigationControllerDelegate { }

//MARK: - Set Images count
extension CollageViewController{
    private func setImages() {
        if collageDoubleView.isHidden == false {
            guard images.count == 2  else { return}
            DispatchQueue.main.async {
                    self.collageDoubleView.showImages(images: self.images)
                    self.images.removeAll()
            }
        } else if collageTripleView.isHidden == false {
            guard images.count == 3 else { return}
            DispatchQueue.main.async {
                    self.collageTripleView.showImages(images: self.images)
                    self.images.removeAll()
            }
        }
    }
}
