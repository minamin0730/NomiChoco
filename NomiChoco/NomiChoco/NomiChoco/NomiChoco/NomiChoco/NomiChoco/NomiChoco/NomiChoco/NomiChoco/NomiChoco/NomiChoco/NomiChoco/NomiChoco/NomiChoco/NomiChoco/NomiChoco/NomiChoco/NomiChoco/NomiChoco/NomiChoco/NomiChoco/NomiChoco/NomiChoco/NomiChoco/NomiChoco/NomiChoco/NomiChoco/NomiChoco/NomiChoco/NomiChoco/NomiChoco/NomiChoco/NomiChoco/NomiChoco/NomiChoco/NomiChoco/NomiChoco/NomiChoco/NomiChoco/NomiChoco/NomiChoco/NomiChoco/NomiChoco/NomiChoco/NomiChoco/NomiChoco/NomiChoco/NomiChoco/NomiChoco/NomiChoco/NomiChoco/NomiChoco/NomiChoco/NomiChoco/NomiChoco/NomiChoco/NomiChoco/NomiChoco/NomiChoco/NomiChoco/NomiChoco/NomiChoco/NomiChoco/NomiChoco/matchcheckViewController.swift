//
//  matchcheckViewController.swift
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/02/28.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

import Foundation
import AVFoundation

class matchcheckViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セッションの作成.
        let mySession: AVCaptureSession! = AVCaptureSession()
        
        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()
        
        // デバイスを格納する.
        var myDevice: AVCaptureDevice!
        
        // バックカメラをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as AVCaptureDevice
            }
        }
        
        // バックカメラから入力(Input)を取得.
        let myVideoInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as AVCaptureDeviceInput
        
        if mySession.canAddInput(myVideoInput) {
            // セッションに追加.
            mySession.addInput(myVideoInput)
        }
        
        // 出力(Output)をMeta情報に.
        let myMetadataOutput: AVCaptureMetadataOutput! = AVCaptureMetadataOutput()
        
        if mySession.canAddOutput(myMetadataOutput) {
            // セッションに追加.
            mySession.addOutput(myMetadataOutput)
            // Meta情報を取得した際のDelegateを設定.
            myMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            // 判定するMeta情報にQRCodeを設定.
            myMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }
        
        // 画像を表示するレイヤーを生成.
        let myVideoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as AVCaptureVideoPreviewLayer
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Viewに追加.
        self.view.layer.addSublayer(myVideoLayer)
        
        // セッション開始.
        mySession.startRunning()
    }
    
    // Meta情報を検出際に呼ばれるdelegate.
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            let qrData: AVMetadataMachineReadableCodeObject  = metadataObjects[0] as AVMetadataMachineReadableCodeObject
            println("\(qrData.type)")
            println("\(qrData.stringValue)")
            
            // SafariでURLを表示.
           // UIApplication.sharedApplication().openURL(NSURL(string: qrData.stringValue)!)
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let value: NSInteger? = qrData.stringValue.toInt()
            if value != nil {
                appDelegate.charaId = value!
            }
            
            println("charaId:\(appDelegate.charaId)")
        }
    }
    @IBAction func pushed(sender: AnyObject) {
       dismissViewControllerAnimated(true, completion: nil)
    }
}