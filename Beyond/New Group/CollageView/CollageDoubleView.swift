//
//  CollageDoubleView.swift
//  Beyond
//
//  Created by John Doe on 2022-11-24.
//

import UIKit

class CollageDoubleView: UIView {
    
    private lazy var imageView1 = UIImageView()
    private lazy var imageView2 = UIImageView()
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        self.isUserInteractionEnabled = true
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath().cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor =  #colorLiteral(red: 0.1137115136, green: 0.1137344316, blue: 0.1137065217, alpha: 1)
        shapeLayer.lineWidth = 5.0

        imageView1.frame = CGRect(x: 0, y: 0, width: createPath().bounds.width, height: createPath().bounds.height)
        imageView1.layer.mask = shapeLayer
        imageView1.image = UIImage(named: "")
       
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = createPath2().cgPath
        shapeLayer2.strokeColor = UIColor.black.cgColor
        shapeLayer2.fillColor =  #colorLiteral(red: 0.1137115136, green: 0.1137344316, blue: 0.1137065217, alpha: 1)
        shapeLayer2.lineWidth = 5.0

        
        imageView2.frame = CGRect(x: (self.frame.width / 2) - (self.frame.width * 0.17), y: 0, width: createPath2().bounds.width - 100, height: createPath2().bounds.height)
        imageView2.layer.mask = shapeLayer2
        imageView2.image = UIImage(named: "")
        
        self.addSubview(imageView2)
        self.addSubview(imageView1)
    }
    
    func showImages(images: [UIImage]) {
        guard !images.isEmpty else { return}
        imageView1.image = images.first!
        imageView2.image = images.last!
    }
    
    func createPath()->UIBezierPath {
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        let padding = self.frame.width * 0.17
        
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth + padding), y: 0)) // the beginning of the trough
        path.addLine(to: CGPoint(x: (centerWidth - padding), y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path
    }
    
    func createPath2()->UIBezierPath {
        let path = UIBezierPath()
        _ = self.frame.width * 0.17
        
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}
