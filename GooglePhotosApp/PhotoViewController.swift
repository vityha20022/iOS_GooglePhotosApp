//
//  PhotoViewController.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 20.02.2023.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    var selectedIndex = 0
    var photos: [GooglePhoto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPhotoImageView()
    }
    
    private func setupPhotoImageView() {
        let photoUrl = photos[selectedIndex].original
        guard let url = URL(string: photoUrl) else {
            return
        }
        
        photoImageView.backgroundColor = .systemBackground
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        photoImageView.sd_setImage(with: url) { [weak self] image, error, cacheType, url in
            if let _ = error {
                self?.photoImageView.image = UIImage(systemName: "circle.slash")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
