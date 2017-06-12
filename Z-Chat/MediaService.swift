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
        
        enum avatarSourceType {
            case photoLibrary
            case camera
        }
        
        weak var viewController: UIViewController?
        var imageHandler: ((_ image: UIImage?) -> Void)?
        
        func getAvatarFrom(source type: avatarSourceType, for viewController: UIViewController, imageHandler: ((_ image: UIImage?) -> Void)?) {
            let avaibleType: Bool
            let validMediaType: Bool
            let sourceType: UIImagePickerControllerSourceType
            switch type {
            case .photoLibrary:
                avaibleType = UIImagePickerController.isSourceTypeAvailable(.photoLibrary) || UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
                validMediaType = UIImagePickerController.availableMediaTypes(for: .photoLibrary)?.contains(kUTTypeImage as String) ?? false
                sourceType = .photoLibrary
            case .camera:
                avaibleType = UIImagePickerController.isSourceTypeAvailable(.camera)
                validMediaType = UIImagePickerController.availableMediaTypes(for: .camera)?.contains(kUTTypeImage as String) ?? false
                sourceType = .camera
            }
            
            if avaibleType && validMediaType {
                self.viewController = viewController
                self.imageHandler = imageHandler
                
                let imagePickerController = UIImagePickerController()
                imagePickerController.modalPresentationStyle = .popover
                imagePickerController.popoverPresentationController?.barButtonItem = viewController.navigationItem.rightBarButtonItem
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                imagePickerController.mediaTypes = [kUTTypeImage as String]
                imagePickerController.sourceType = sourceType
                
                viewController.present(imagePickerController, animated: true, completion: nil)
            }
            
        }
        
        func choosePhotoFromLibrary(for vc: UIViewController, imageHandler: ((_ image: UIImage?) -> Void)?) {
            getAvatarFrom(source: .photoLibrary, for: vc, imageHandler: imageHandler)
        }
        
        func takePhotoFromCamera(for vc: UIViewController, imageHandler: ((_ image: UIImage?)-> Void)?) {
            getAvatarFrom(source: .camera, for: vc, imageHandler: imageHandler)
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
