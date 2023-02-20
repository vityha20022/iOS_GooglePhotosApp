//
//  PhotosCollectionViewCell.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 19.02.2023.
//

import UIKit
import SDWebImage

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    var googlePhoto: GooglePhoto! {
        didSet {
            let photoUrl = googlePhoto.original
            guard let url = URL(string: photoUrl) else {
                return
            }

            photoImageView.backgroundColor = .systemBackground
            photoImageView.layer.cornerRadius = 16
            photoImageView.layer.masksToBounds = true
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            photoImageView.sd_setImage(with: url) { [weak self] _, error, _, _ in
                if error != nil {
                    self?.photoImageView.image = UIImage(systemName: "circle.slash")
                }
            }
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.sd_cancelCurrentImageLoad()
    }
}
