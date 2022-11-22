//
//  FilterViewModel.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import Foundation
import UIKit
import GPUImage


protocol FilterViewModelProtocol {
    func filteredImage(image: UIImage)
    func filterationList(index: Int)
    func getCategories() -> [Category]
    func filterImage(image: UIImage,index: Int) -> UIImage
    func catInitialize()

}
class FilterViewModel: FilterViewModelProtocol{
   
    
    var image: UIImage?{
        didSet{
            DispatchQueue.main.async {
                guard let image = self.image else{
                    return
                }
                self.view.imageUpdate(image: image)
            }
        }
    }
    
    
    weak private var view: FilterViewProtocol!
    var categories: [Category] = []{
        didSet{
            DispatchQueue.main.async {
                self.view.categoriesUpdate(categories: self.categories)
            }
        }
    }
    var filters: [Filter] = []{
        didSet{
            DispatchQueue.main.async {
                self.view.filtersUpdate(filters: self.filters)
            }
        }
    }

    init(view: FilterViewProtocol) {
        self.view = view
    }
        
}


extension FilterViewModel{
    func filteredImage(image: UIImage) {
        self.image = image
    }
    func filterationList(index: Int){
        filters = categories[index].categoryType
    }
    func getCategories() -> [Category]{
        if categories.count > 0 {
            return categories
        }
        return  []
    }
    func filterImage(image: UIImage, index: Int) -> UIImage{
        if filters.count > 0 {
            let filter = filters[index].filterType
            guard let outputImage = filter?.image(byFilteringImage: image) else { return UIImage() }
            return outputImage
        }
     return UIImage()
    }
    
    func catInitialize(){
      mocData()
    }
    
}
extension FilterViewModel{
    
    private func mocData(){
        categories.append(Category(categoryType: [Filter(filterType: GPUImageBrightnessFilter()),Filter(filterType: GPUImageExposureFilter()),Filter(filterType: GPUImageContrastFilter()),Filter(filterType: GPUImageSaturationFilter()),Filter(filterType: GPUImageColorMatrixFilter()),Filter(filterType: GPUImageLevelsFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageRGBFilter()),Filter(filterType: GPUImageHueFilter()),Filter(filterType: GPUImageLookupFilter()),Filter(filterType: GPUImageWhiteBalanceFilter()),Filter(filterType: GPUImageToneCurveFilter()),Filter(filterType: GPUImageHighlightShadowFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageWhiteBalanceFilter()),Filter(filterType: GPUImageFalseColorFilter()),Filter(filterType: GPUImageAverageColor()),Filter(filterType: GPUImageMonochromeFilter()),Filter(filterType: GPUImageColorInvertFilter()),Filter(filterType: GPUImageLevelsFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageFalseColorFilter()),Filter(filterType: GPUImageHazeFilter()),Filter(filterType: GPUImageSepiaFilter()),Filter(filterType: GPUImageOpacityFilter()),Filter(filterType: GPUImageSolidColorGenerator()),Filter(filterType: GPUImageLuminanceThresholdFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageMonochromeFilter()),Filter(filterType: GPUImageSepiaFilter()),Filter(filterType: GPUImageHistogramGenerator()),Filter(filterType: GPUImageAverageColor()),Filter(filterType: GPUImageLuminosity()),Filter(filterType: GPUImageChromaKeyFilter())]))
        
    }
    
}
