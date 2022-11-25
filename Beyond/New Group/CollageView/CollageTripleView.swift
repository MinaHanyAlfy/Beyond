//
//  CollageTripleView.swift
//  Beyond
//
//  Created by John Doe on 2022-11-24.
//

import UIKit

class CollageTripleView: UIView {
    
    private lazy var imagesView: [UIImageView] = [UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width / 2, height: self.frame.height)),
                                                  UIImageView(frame: CGRect(x: self.frame.width / 2, y: 0, width: self.frame.width / 2, height: 2 * frame.height / 3)),
                                                  UIImageView(frame: CGRect(x: self.frame.width / 2, y: (frame.height / 2) - (frame.height * 0.17) , width: self.frame.width / 2, height: 2 * frame.height / 3))]
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape(){
        self.isUserInteractionEnabled = true

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath().cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor =  #colorLiteral(red: 0.1137115136, green: 0.1137344316, blue: 0.1137065217, alpha: 1)
        shapeLayer.lineWidth = 5.0
        
        imagesView[1].layer.mask = shapeLayer
        
        addSubview(imagesView[2])
        addSubview(imagesView[1])
        addSubview(imagesView[0])
    }
    
    private func createPath()->UIBezierPath {
        let path = UIBezierPath()
        
        let padding = self.frame.height * 0.1
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height / 2 + padding))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height / 2 - padding))
        path.close()
        
        return path
    }
    
    func showImages(images: [UIImage]) {
        guard images.count == imagesView.count else { return}
        for (i,n) in images.enumerated() {
            imagesView[i].image = n
        }
    }
}
