//
//  MediaService.swift
//  Z-Chat
//
//  Created by Zxzerster on 2017/6/8.
//  Copyright © 2017年 Zxzerster. All rights reserved.
//

import UIKit
import MobileCoreServices

class MediaService {
    
    static let instance: MediaService = MediaService()
    
    let image = Image()
    
    class Image: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        weak var viewController: UIViewController?
        var imageHandler: ((_ image: UIImage?) -> Void)?
        
        func choosePhotoFromLibrary(for vc: UIViewController, imageHandler: ((_ image: UIImage?) -> Void)?) {
            // Check source type
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) || UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                viewController = vc
                self.imageHandler = imageHandler
                
                let imagePickController = UIImagePickerController()
                imagePickController.modalPresentationStyle = .popover
                imagePickController.popoverPresentationController?.barButtonItem = vc.navigationItem.rightBarButtonItem
                
                imagePickController.delegate = self
                imagePickController.allowsEditing = true
                imagePickController.mediaTypes = [kUTTypeImage as String]
                imagePickController.sourceType = .photoLibrary
                vc.present(imagePickController, animated: true, completion: nil)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            viewController?.dismiss(animated: true) {
                [unowned self] in
                self.imageHandler?(editedImage)
            }
        }
    }
    
}
