//
//  MLDemoViewController.swift
//  MercenaryDemo
//
//  Created by ross zhao on 2018/1/24.
//  Copyright © 2018年 mingzhao. All rights reserved.
//

import UIKit
import ImageIO
import CoreML

class MLDemoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photo: UIImageView!
    
    var image : UIImage!
    var cameraPicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func callCameraAction(_ sender: Any) {
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    @IBAction func recognitionAction(_ sender: Any) {
        
        let model = Resnet50()
        
        guard let pixelBufferImage = self.pixelBuffer(from: image) else {
            fatalError()
        }
        guard let output = try? model.prediction(fromImage: pixelBufferImage) else {
            fatalError("Unexpected runtime error.")
        }
       
        let alertController = UIAlertController(title: "识别结果",
                                                message: output.classLabel/*self.JSONStringify(value: output.classLabelProbs as AnyObject)*/, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        //获得照片
        let tmpImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let newWidth:CGFloat = 224.0
        let newHeight:CGFloat = 224.0
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        tmpImage.draw(in:CGRect(x:0, y:0, width:newWidth, height:newHeight))
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        photo.image = image;
    }
    
    func pixelBuffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    func getCVPixelBuffer(_ image: CGImage) -> CVPixelBuffer? {
        let imageWidth = Int(image.width)
        let imageHeight = Int(image.height)
        
        let attributes : [NSObject:AnyObject] = [
            kCVPixelBufferCGImageCompatibilityKey : true as AnyObject,
            kCVPixelBufferCGBitmapContextCompatibilityKey : true as AnyObject
        ]
        
        var pxbuffer: CVPixelBuffer? = nil
        CVPixelBufferCreate(kCFAllocatorDefault,
                            imageWidth,
                            imageHeight,
                            kCVPixelFormatType_32ARGB,
                            attributes as CFDictionary?,
                            &pxbuffer)
        
        if let _pxbuffer = pxbuffer {
            let flags = CVPixelBufferLockFlags(rawValue: 0)
            CVPixelBufferLockBaseAddress(_pxbuffer, flags)
            let pxdata = CVPixelBufferGetBaseAddress(_pxbuffer)
            
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
            let context = CGContext(data: pxdata,
                                    width: imageWidth,
                                    height: imageHeight,
                                    bitsPerComponent: 8,
                                    bytesPerRow: CVPixelBufferGetBytesPerRow(_pxbuffer),
                                    space: rgbColorSpace,
                                    bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
            
            if let _context = context {
                _context.draw(image, in: CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight))
            }
            else {
                CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
                return nil
            }
            
            CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
            return _pxbuffer;
        }
        
        return nil
    }
    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                print("error")
                //Access error here
            }
        }
        return ""
    }
}
