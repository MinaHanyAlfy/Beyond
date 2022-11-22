//
//  CollageViewController.swift
//  Beyond
//
//  Created by John Doe on 2022-11-21.
//

import UIKit

class CollageViewController: UIViewController {
    var doubleView = DoubleCollageView()
    var tripleView = TripleCollageView()
//
//    var tripleViewTap: UITapGestureRecognizer? = nil
//    var doubleViewTap: UITapGestureRecognizer? = nil
//    var imageView = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap = UIGestureRecognizer(target: self, action: #selector(self.handleDoubleViewTap))
//        imageView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    
    }

    
    @IBAction func chooseCollageAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Number of Image", message: nil, preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "2 Images", style: UIAlertAction.Style.default, handler: { action in
            
            
            if self.view.contains(self.tripleView) {
                self.tripleView.removeFromSuperview()
                
            }
            self.view.addSubview(self.doubleView)
//            self.doubleViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleDoubleViewTap))
//            self.doubleView.addGestureRecognizer(self.doubleViewTap!)
//            self.doubleView.isUserInteractionEnabled = true
        }))
        alert.addAction(UIAlertAction(title: "3 Images", style: UIAlertAction.Style.default, handler: { action in
           
            if self.view.contains(self.doubleView) {
                self.doubleView.removeFromSuperview()
            }
            self.view.addSubview(self.tripleView)
//            self.tripleViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTripleViewTap))
//            self.tripleView.addGestureRecognizer(self.tripleViewTap!)
//            self.tripleView.isUserInteractionEnabled = true
       
        }))

               // show the alert
               self.present(alert, animated: true, completion: nil)
    }
    
//    @objc func handleDoubleViewTap() {
//        // handling code
//        print("double image")
//    }
//
//    @objc func handleTripleViewTap() {
//        // handling code
//        print("triple image")
//    }
}
