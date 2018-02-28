//
//  UIImage+EXtension.swift
//  SwiftNetWorkZF
//
//  Created by ZQXQ on 2018/2/9.
//  Copyright © 2018年 PT Matahari Makmur Abadi. All rights reserved.
//

import UIKit

extension UIImage {
   /// 修复图片旋转
    func fixOrieentation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        var transform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
        default:
            break
        }
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        default:
            break
        }
        let ctx = CGContext.init(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect.init(x: 0, y: 0, width: size.height, height: size.width))
            break
        default:
            ctx?.draw(self.cgImage!, in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        }
        let cgImage: CGImage = (ctx?.makeImage())!
        let ima = UIImage.init(cgImage: cgImage)
        return ima
        
        
        
    }
}
