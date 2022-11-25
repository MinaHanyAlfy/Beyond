//
//  FilterCollectionViewCell.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    private func setupCell() {
        clipsToBounds = true
        layer.cornerRadius = frame.height / 4
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    func changeTint(index: Int){
        switch index{
        case 0:
            imageView.tintColor = .blue
        case 1:
            imageView.tintColor = .red
        case 2:
            imageView.tintColor = .green
        case 3:
            imageView.tintColor = .yellow
        case 4:
            imageView.tintColor = .cyan
        default:
            imageView.tintColor = .black
            
        }
    }

}
