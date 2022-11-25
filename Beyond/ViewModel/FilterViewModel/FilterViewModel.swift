//
//  FilterViewModel.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import Foundation
import GPUImage

protocol FilterViewModelProtocol {
    func filteredImage(image: UIImage)
    func filterationList(index: Int)
    func getCategories() -> [Category]
    func filterImage(image: UIImage,index: Int,isSaved: Bool)
    func catInitialize()
}

class FilterViewModel {
   
    weak private var view: FilterViewProtocol!
    
    private var image: UIImage? {
        didSet{
            DispatchQueue.main.async {
                guard let image = self.image else { return }
                self.view.imageUpdate(image: image)
            }
        }
    }
    private var categories: [Category] = [] {
        didSet{
            DispatchQueue.main.async {
                self.view.categoriesUpdate(categories: self.categories)
            }
        }
    }
    private var filters: [Filter] = [] {
        didSet{
            DispatchQueue.main.async {
                self.view.filtersUpdate(filters: self.filters)
            }
        }
    }
    private var imageFiltered: UIImage? {
        didSet{
            DispatchQueue.main.async {
                guard let image = self.imageFiltered else { return }
                self.view.imageFiltered(image: image)
            }
        }
    }
    
    init(view: FilterViewProtocol) {
        self.view = view
    }
        
}

//MARK: - FilterViewModelProtocol
extension FilterViewModel: FilterViewModelProtocol {
    func filteredImage(image: UIImage) {
        self.image = image
    }
    
    func filterationList(index: Int) {
        filters = categories[index].categoryType
    }
    
    func getCategories() -> [Category] {
        if categories.count > 0 {
            return categories
        }
        return  []
    }
    
    func filterImage(image: UIImage, index: Int,isSaved: Bool) {
        if filters.count > 0 {
            let filter = filters[index].filterType
            if isSaved {
                self.imageFiltered = (filter?.image(byFilteringImage: image))!
            } else {
                self.image = filter?.image(byFilteringImage: image) ?? GPUImageRGBFilter().image(byFilteringImage: image)
            }
        }
    }
    
    func catInitialize() {
      mocData()
    }
    
}

//MARK: - MocData For Filters
extension FilterViewModel {
    private func mocData(){
        categories.append(Category(categoryType: [Filter(filterType: GPUImageBrightnessFilter()),Filter(filterType: GPUImageExposureFilter()),Filter(filterType: GPUImageContrastFilter()),Filter(filterType: GPUImageSaturationFilter()),Filter(filterType: GPUImageColorMatrixFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageRGBFilter()),Filter(filterType: GPUImageHueFilter()),Filter(filterType: GPUImageLookupFilter()),Filter(filterType: GPUImageToneCurveFilter()),Filter(filterType: GPUImageHighlightShadowFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageWhiteBalanceFilter()),Filter(filterType: GPUImageAverageColor()),Filter(filterType: GPUImageMonochromeFilter()),Filter(filterType: GPUImageColorInvertFilter()),Filter(filterType: GPUImageLevelsFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageFalseColorFilter()),Filter(filterType: GPUImageHazeFilter()),Filter(filterType: GPUImageOpacityFilter()),Filter(filterType: GPUImageSolidColorGenerator()),Filter(filterType: GPUImageLuminanceThresholdFilter())]))
        categories.append(Category(categoryType: [Filter(filterType: GPUImageMonochromeFilter()),Filter(filterType: GPUImageSepiaFilter()),Filter(filterType: GPUImageHistogramGenerator()),Filter(filterType: GPUImageLuminosity()),Filter(filterType: GPUImageChromaKeyFilter())]))
        
    }
    
}
