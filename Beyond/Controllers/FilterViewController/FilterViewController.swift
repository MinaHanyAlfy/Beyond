//
//  FilterViewController.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import UIKit
import GPUImage

protocol FilterViewProtocol: AnyObject {
    func imageUpdate(image: UIImage)
    func filtersUpdate(filters: [Filter])
    func categoriesUpdate(categories: [Category])
    
}
class FilterViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var imgReferal: UIImage?
    
    private var viewModel: FilterViewModelProtocol!
    var categories: [Category]?{
        didSet{
            categoriesCollectionView.reloadData()
        }
    }
    var filters : [Filter]?{
        didSet{
            filtersCollectionView.reloadData()
        }
    }
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FilterViewModel(view: self)
        viewModel.catInitialize()
        
        registerCollections()
        
    }
    private func registerCollections() {
        filtersCollectionView.dataSource = self
        filtersCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        filtersCollectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    @IBAction func addImageAction(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func saveImageAction(_ sender: Any) {
        if let pickedImage = imageView.image {
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            }
    }
    

}
extension FilterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
       
        print(tempImage)
//        imageView.image = tempImage
        viewModel.filteredImage(image: tempImage)
        imgReferal = tempImage
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}


extension FilterViewController: FilterViewProtocol{
    
    func imageUpdate(image: UIImage) {
        self.imageView.image = image
        categoriesCollectionView.reloadData()
        filtersCollectionView.reloadData()
    }
    
    func filtersUpdate(filters: [Filter]) {
        self.filters = filters
    }
    
    func categoriesUpdate(categories: [Category]) {
        self.categories = categories
    }
    
}


extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case filtersCollectionView:
            return filters?.count ?? 0
            //Categories
        default:
            return categories?.count ?? 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case filtersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCollectionViewCell
           
                guard let imgReferal = imgReferal else {return UICollectionViewCell()}
                guard let filters = filters else{return UICollectionViewCell()}
                DispatchQueue.main.async {
                    cell.imageView.image = filters[indexPath.row].filterType?.image(byFilteringImage: imgReferal)
                }
                
            
            return cell
        
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCollectionViewCell
            cell.changeTint(index: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5 - 8 , height: collectionView.frame.height - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case categoriesCollectionView:
            guard let imgReferal = self.imgReferal else{return}
            viewModel.filterationList(index: indexPath.row)
            filtersCollectionView.reloadData()
        default:
                DispatchQueue.main.async {
                    guard let imgReferal = self.imgReferal else{ return }
                    self.imageView.image = self.viewModel.filterImage(image: imgReferal, index: indexPath.row)
                }
            
            break
            
        }
    }
    
}
