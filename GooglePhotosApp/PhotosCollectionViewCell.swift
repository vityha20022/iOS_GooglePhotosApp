//
//  PhotosCollectionViewCell.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 18.02.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    /*var unsplashPhoto: UnsplashSearchPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {
                return
            }

            photoImageView.sd_setImage(with: url)
        }
    }*/

    /*private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBackground
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()*/

    // MARK: - UICollectionViewCell

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPhotoImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }

    // MARK: - Setup UI Elements
    private func setupPhotoImageView() {
        photoImageView.backgroundColor = .systemBackground
        photoImageView.layer.cornerRadius = 16
        photoImageView.layer.masksToBounds = true
        photoImageView.contentMode = .scaleAspectFill
    }
}

