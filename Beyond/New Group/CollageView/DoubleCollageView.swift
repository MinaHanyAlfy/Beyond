//
//  CollageView.swift
//  Beyond
//
//  Created by John Doe on 2022-11-20.
//

import UIKit

class DoubleCollageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Start Line
        isUserInteractionEnabled = true
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 80, y: 120))
        path.addLine(to: CGPoint(x:  300, y: 120))
        path.addLine(to: CGPoint(x: 300, y: 340))
        path.addLine(to: CGPoint(x: 80, y: 340))
        path.addLine(to: CGPoint(x: 80, y: 120))
        path.addLine(to: CGPoint(x: 243, y: 120))
        path.addLine(to: CGPoint(x: 170, y: 340))

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 4.0
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.black.cgColor
        layer.addSublayer(shape)
        
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    @objc func getImages(){
//        print("double")
//        
//    }

}
