//
//  ViewController.swift
//  SwiftTakePhotoDemo
//
//  Created by ZQXQ on 2018/2/28.
//  Copyright © 2018年 NO Origanization At Present. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @objc var takePhotoBtn : UIButton!
    @objc var image : UIImageView!
    let photoImage = ZFRadioAlbum()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .lightGray
        navigationItem.title = "😄😂😄"
        createTakePhotoUI()

        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func createTakePhotoUI() {
        takePhotoBtn = UIButton.createButton(title: "选择照片", backGroundColor: UIColor.white, titleColor: UIColor.black, titleFont: 15, imageName: "", target: self, action: #selector(ClickaAtion))
        view.addSubview(takePhotoBtn)
        takePhotoBtn.frame = CGRect.init(x: 0, y: 0, width: 80, height: 30)
        takePhotoBtn.center = CGPoint.init(x: view.frame.size.width / 2, y: 200)
        
        image = UIImageView()
        image.backgroundColor = UIColor.white
        view.addSubview(image)
        image.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        image.center = CGPoint.init(x: view.frame.size.width / 2, y: 310)
        
    }
    @objc fileprivate func ClickaAtion() {
        print("点击照片")
        
        photoImage.showPhotoBox()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            weak var weakSlef = self
            self.photoImage.selectedImageBlock = {
                (image) in
                weakSlef?.image.image = image
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

