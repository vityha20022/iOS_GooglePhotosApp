//
//  PhotosCollectionViewController.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 18.02.2023.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    private let networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    private var photos = [GooglePhoto]()
    private let placeholderString = "Start looking please... 👀"
    
    private let itemPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        collectionView.setMessage(placeholderString)
    }
    
    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.keyboardDismissMode = .onDrag
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhotoSegue", sender: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let googlePhoto = photos[indexPath.item]
        cell.googlePhoto = googlePhoto

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoSegue" {
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                let destinationController = segue.destination as! PhotoViewController
                destinationController.photos = photos
                destinationController.selectedIndex = indexPaths[0].row
                collectionView.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
           
    }
}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            if !searchText.isEmpty {
                self.collectionView.setActivityIndicator()
                self.networkDataFetcher.fetchPhotos(searchTerm: searchText) { [weak self] data, _ in
                    self?.collectionView.removeBackgroundView()
                    if let fetchedPhotos = data {
                        self?.collectionView.removeBackgroundView()
                        self?.photos = fetchedPhotos.images_results
                        self?.collectionView.reloadData()
                    }
                }
            } else {
                self.photos = []
                self.collectionView.reloadData()
                
                self.collectionView.setMessage(self.placeholderString)
            }
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        photos = []
        collectionView.reloadData()
        
        collectionView.setMessage(placeholderString)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow
        let height = CGFloat(photo.original_height) * widthPerItem / CGFloat(photo.original_width)
        return CGSize(width: widthPerItem, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - UICollectionView

extension UICollectionView {
    func setMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }
    
    func removeBackgroundView() {
        self.backgroundView = nil
    }
    
    func setActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        self.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
}
