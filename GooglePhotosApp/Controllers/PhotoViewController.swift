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
    @IBOutlet weak var showSourceWebPageButton: UIButton!
    @IBOutlet weak var prevPhotoButton: UIButton!
    @IBOutlet weak var nextPhotoButton: UIButton!
    
    var selectedIndex = 0
    var photos: [GooglePhoto] = []
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElemnts()
    }
    
    // MARK: - Setup UI Elements
    
    private func setupUIElemnts() {
        setupPhotoImageView()
        setupNavigationButtons()
    }
    
    private func setupPhotoImageView() {
        let photoUrl = photos[selectedIndex].original
        guard let url = URL(string: photoUrl) else {
            return
        }
        
        photoImageView.backgroundColor = .systemBackground
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        photoImageView.sd_setImage(with: url) { [weak self] _, error, _, _ in
            if error != nil {
                self?.photoImageView.image = UIImage(systemName: "circle.slash")
            }
        }
    }
    
    private func setupNavigationButtons() {
        prevPhotoButton.isEnabled = selectedIndex > 0
        nextPhotoButton.isEnabled = selectedIndex < photos.count - 1
    }
    
    // MARK: - IBActions
    
    @IBAction func prevButtonClicked(_ sender: Any) {
        selectedIndex -= 1
        setupUIElemnts()
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        selectedIndex += 1
        setupUIElemnts()
    }
    
    @IBAction func showSourcieWevPageButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "showWebViewSegue", sender: nil)
    }
    
    @IBAction func handleRightSwipe(_ sender: Any) {
        if prevPhotoButton.isEnabled {
            selectedIndex -= 1
            setupUIElemnts()
        }
    }
    
    @IBAction func handleLeftSwipe(_ sender: Any) {
        if nextPhotoButton.isEnabled {
            selectedIndex += 1
            setupUIElemnts()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebViewSegue" {
            let destinationController = segue.destination as! PhotoWebViewController
            destinationController.url = photos[selectedIndex].link
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
           
    }
}
