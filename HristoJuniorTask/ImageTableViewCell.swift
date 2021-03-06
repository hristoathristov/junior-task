//
//  ImageTableViewCell.swift
//  HristoJuniorTask
//
//  Created by Hristo Hristov on 17/9/17.
//  Copyright © 2017 allterco. All rights reserved.
//

import UIKit

@objc protocol ImageTableViewCellDelegate {
    @objc optional func tapped(_ button: UIButton, in cell: ImageTableViewCell)
}

class ImageTableViewCell: UITableViewCell {

    @IBOutlet private var aspectFitImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBAction func tapped(_ sender: UIButton) {
        delegate?.tapped?(sender, in: self)
    }
    var delegate: ImageTableViewCellDelegate?
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                aspectFitImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                aspectFitImageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func set(_ image : UIImage) {
        
        let aspect = image.size.width / image.size.height
        
        aspectConstraint = NSLayoutConstraint(item: aspectFitImageView, attribute: .width, relatedBy: .equal, toItem: aspectFitImageView, attribute: .height, multiplier: aspect, constant: 0.0)
        
        aspectFitImageView.image = image
    }

}
