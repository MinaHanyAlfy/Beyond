//
//  ViewController.swift
//  Beyond
//
//  Created by John Doe on 2022-11-20.
//

import UIKit


class ViewController: UIViewController {
    var path: UIBezierPath!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let bezierPathView = DoubleCollageView(frame: CGRect(x: self.view.frame.width/2-self.view.frame.width/4, y: self.view.frame.height/2-self.view.frame.width/4,
                                                              width: self.view.frame.width/2,
                                                              height: self.view.frame.width/2))
//        bezierPathView.backgroundColor = .white
        
        
        self.view.addSubview(bezierPathView)
        
    }
  
    

    
}

