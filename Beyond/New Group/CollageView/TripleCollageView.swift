//
//  TripleCollageView.swift
//  Beyond
//
//  Created by John Doe on 2022-11-22.
//

import UIKit

class TripleCollageView: UIView {

   
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let path = UIBezierPath()
        //Start Line
        path.move(to: CGPoint(x: 80, y: 120))
        path.addLine(to: CGPoint(x:  300, y: 120))
        path.addLine(to: CGPoint(x: 300, y: 340))
        path.addLine(to: CGPoint(x: 80, y: 340))
        path.addLine(to: CGPoint(x: 80, y: 120))
        //End Box
        path.addLine(to: CGPoint(x: 190, y: 120))
        path.addLine(to: CGPoint(x: 190, y: 340))
        //End Mid Line
        path.addLine(to: CGPoint(x: 190, y: 240))
        path.addLine(to: CGPoint(x: 300, y: 260))
        
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


}
