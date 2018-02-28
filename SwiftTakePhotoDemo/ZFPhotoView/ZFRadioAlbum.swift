//
//  ZFRadioAlbum.swift
//  SwiftNetWorkZF
//
//  Created by ZQXQ on 2018/2/10.
//  Copyright © 2018年 PT Matahari Makmur Abadi. All rights reserved.
//

import UIKit

class ZFRadioAlbum: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //图片回调
    var selectedImageBlock: ((UIImage) -> ())?//block回调
    //显示提示框
    func showPhotoBox() {
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let takeBtn = UIAlertAction.init(title: "拍照", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                UIApplication.shared.keyWindow?.rootViewController?.present(picker, animated: true, completion: nil)
            }
            else {
                print("模拟其中无法打开照相机,请在真机中使用")
            }
        })
        let selectPhotos = UIAlertAction.init(title: "相册", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            // 是否支持相册
            if UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypePhotoLibrary){
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                picker.setImagePickerStyle(bgroundColor: UIColor.white, titleColor: UIColor.black, buttonTitleColor: UIColor.black)
                // 修改导航栏
                UIApplication.shared.keyWindow?.rootViewController?.present(picker, animated: true, completion: nil)
            }else{
                print("读取相册失败")
                
            }
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takeBtn)
        actionSheet.addAction(selectPhotos)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
        
    }
    /*
     指定用户选择的媒体类型 UIImagePickerControllerMediaType
     原始图片 UIImagePickerControllerOriginalImage
     修改后的图片 UIImagePickerControllerEditedImage
     裁剪尺寸 UIImagePickerControllerCropRect
     媒体的URL UIImagePickerControllerMediaURL
     原件的URL UIImagePickerControllerReferenceURL
     当来数据来源是照相机的时候这个值才有效 UIImagePickerControllerMediaMetadata
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 获取选择的原图
        let pickerImage = (info[UIImagePickerControllerEditedImage] as! UIImage).fixOrieentation()
        print(pickerImage)
        //是否支持相册
        if UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypePhotoLibrary) {
            
        }
        else if(UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypeCamera)) {
            //图片保存到相册
            UIImageWriteToSavedPhotosAlbum(pickerImage, self, Selector(("imageSave:error:contextInfo:")), nil)
        }
        if self.selectedImageBlock != nil {
            self.selectedImageBlock!(pickerImage)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}
