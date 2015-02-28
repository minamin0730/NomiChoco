//
//  CameraUtil.swift
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/02/28.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CameraUtil {
    
    // sampleBufferからUIImageへ変換
    class func imageFromSampleBuffer(sampleBuffer: CMSampleBufferRef) -> UIImage {
        let imageBuffer: CVImageBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        // ベースアドレスをロック
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
        
        // 画像データの情報を取得
        let baseAddress: UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, UInt(0))
        
        let bytesPerRow: UInt = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width: UInt = CVPixelBufferGetWidth(imageBuffer)
        let height: UInt = CVPixelBufferGetHeight(imageBuffer)
        
        // RGB色空間を作成
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()
        
        // Bitmap graphic contextを作成
        let bitsPerCompornent: UInt = 8
        var bitmapInfo = CGBitmapInfo((CGBitmapInfo.ByteOrder32Little.rawValue | CGImageAlphaInfo.PremultipliedFirst.rawValue) as UInt32)
        let newContext: CGContextRef = CGBitmapContextCreate(baseAddress, width, height, bitsPerCompornent, bytesPerRow, colorSpace, bitmapInfo) as CGContextRef
        
        // Quartz imageを作成
        let imageRef: CGImageRef = CGBitmapContextCreateImage(newContext)
        
        // UIImageを作成
        let resultImage: UIImage! = UIImage(CGImage: imageRef)
        
        return resultImage
    }
    
}