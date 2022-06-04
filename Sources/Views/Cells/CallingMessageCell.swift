//
//  AudioCallMessageCell.swift
//  MessageKit
//
//  Created by KhoiLe on 31/05/2022.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
open class CallingMessageCell: MessageContentCell {
    open var functionButton: UIButton = {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .init(red: CGFloat(108) / 255.0, green: CGFloat(164) / 255.0, blue: CGFloat(212) / 255.0, alpha: 1.0)
            config.baseForegroundColor = UIColor.white
            config.imagePadding = 6
            
            let button = UIButton(configuration: config)
            button.contentHorizontalAlignment = .left
            
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            
            // Add shadow
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.layer.masksToBounds = false
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 1
            
            return button
        } else {
            // Fallback on earlier versions
            let button = UIButton()
            button.imageView?.image?.withTintColor(.systemGray2)
            button.contentHorizontalAlignment = .left
            
            button.backgroundColor = .init(red: CGFloat(108) / 255.0, green: CGFloat(164) / 255.0, blue: CGFloat(212) / 255.0, alpha: 1.0)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            
            // Add shadow
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.layer.masksToBounds = false
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 1
            
            return button
        }
    }()
    
    open func setupConstraints() {
        functionButton.fillSuperview()
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(functionButton)
        setupConstraints()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        switch message.kind {
        case .audioCall(let callMessage):
            let image = resizeImage(image: UIImage(systemName: "phone.circle")!, targetSize: CGSize(width: 40, height: 40)).withTintColor(UIColor.systemBlue)
        
            functionButton.setTitle(callMessage, for: .normal)
            functionButton.setImage(image, for: .normal)
            break
        case .videoCall(let callMessage):
            let image = resizeImage(image: UIImage(systemName: "video.circle")!, targetSize: CGSize(width: 40, height: 40)).withTintColor(UIColor.systemBlue)
            
            functionButton.setTitle(callMessage, for: .normal)
            functionButton.setImage(image, for: .normal)
            break
        default:
            break
        }
    }
    
    /// Handle tap gesture on contenview
    open override func handleTapGesture(_ gesture: UIGestureRecognizer) {
        let touchLocation = gesture.location(in: functionButton)
        
        guard functionButton.frame.contains(touchLocation) else {
            super.handleTapGesture(gesture)
            return
        }
        delegate?.didTapCalling(in: self)
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
