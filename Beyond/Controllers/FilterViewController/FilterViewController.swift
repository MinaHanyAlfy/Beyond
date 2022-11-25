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
    func imageFiltered(image: UIImage)
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    private var imgReferal: UIImage?
    private var imgLowQuality: UIImage?
    private var viewModel: FilterViewModelProtocol!
    private var categories: [Category]?{
        didSet{
            categoriesCollectionView.reloadData()
        }
    }
    private var filters : [Filter]?{
        didSet{
            filtersCollectionView.reloadData()
        }
    }
    private var index: Int?
    
    private let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupCells()
        setupImagePickerController()
    }
    
    private func setupViewModel() {
        viewModel = FilterViewModel(view: self)
        viewModel.catInitialize()
    }
    private func setupImagePickerController() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
    }
    
    private func setupCells() {
        categoriesCollectionView.registerCell(collectionViewCell: FilterCollectionViewCell.self)
        filtersCollectionView.registerCell(collectionViewCell: FilterCollectionViewCell.self)
    }
    
    @IBAction func addImageAction(_ sender: Any) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveImageAction(_ sender: Any) {
        guard let index = index, let pickedImage = imgReferal else { return }
        viewModel.filterImage(image: pickedImage, index: index,isSaved: true)
    }
}

//MARK: - UIImagePickerControllerDelegate
extension FilterViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
       
        print(tempImage)
        viewModel.filteredImage(image: tempImage)
        imgReferal = tempImage
        imgLowQuality = UIImage(data: tempImage.jpeg(.low)!)
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UINavigationControllerDelegate
extension FilterViewController: UINavigationControllerDelegate {}

//MARK: - FilterViewProtocol
extension FilterViewController: FilterViewProtocol {
    
    func imageUpdate(image: UIImage) {
        self.imageView.image = image
        categoriesCollectionView.reloadData()
        filtersCollectionView.reloadData()
    }
    
    func filtersUpdate(filters: [Filter]) {
        self.filters = filters
        filtersCollectionView.reloadData()
    }
    
    func categoriesUpdate(categories: [Category]) {
        self.categories = categories
    }
    
    func imageFiltered(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
}

//MARK: - UICollectionViewDataSource
extension FilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case filtersCollectionView:
            return filters?.count ?? 0
        default:
            return categories?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deqeueReusableCell(collectionViewCell: FilterCollectionViewCell.self, indexPath: indexPath)
        
        switch collectionView {
        case filtersCollectionView:
            if let imgReferal = imgReferal, let filters = filters ,let image = filters[indexPath.row].filterType?.image(byFilteringImage: imgReferal) {
                cell.setImage(image: image)
            }
        default:
            cell.changeTint(index: indexPath.row)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension FilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case categoriesCollectionView:
            viewModel.filterationList(index: indexPath.row)
        default:
                DispatchQueue.main.async {
                    guard let imgLowQuality = self.imgLowQuality else{ return }
                    self.viewModel.filterImage(image: imgLowQuality, index: indexPath.row,isSaved: false)
                    self.index = indexPath.row
                }
            break
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width / 5 - 8 , height: collectionView.frame.height - 8)
     }
}
                                    

