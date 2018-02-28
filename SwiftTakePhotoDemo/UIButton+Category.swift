
//
//  UIButton+Category.swift
//  SwiftTakePhotoDemo
//
//  Created by ZQXQ on 2018/2/28.
//  Copyright © 2018年 NO Origanization At Present. All rights reserved.
//

import UIKit
extension UIButton {
    //构造button
    class func createButton(title: String, backGroundColor: UIColor, titleColor: UIColor, titleFont: CGFloat, imageName : String, target : Any, action: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: UIControlState())
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backGroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
