//
//  PhotosCollectionViewController.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 18.02.2023.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    let networkDataFetcher = NetworkDataFetcher()
    private var photos = [GooglePhoto]()
    private let itemPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        
        networkDataFetcher.fetchPhotos(searchTerm: "a") { [weak self] data, error in
            if let fetchedPhotos = data {
                self?.photos = fetchedPhotos.images_results
                self?.collectionView.reloadData()
            }
        }
        
    }
    
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
        // click
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let googlePhoto = photos[indexPath.item]
        cell.googlePhoto = googlePhoto

        return cell
    }
}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /*timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            if !searchText.isEmpty {
                self.networkDataFetcher.fetchSearchImages(searchTerm: searchText) { [weak self] searchResults in
                    guard let fetchedPhotos = searchResults else {
                        return
                    }
                    self?.photos = fetchedPhotos.results
                    self?.collectionView.reloadData()
                }
            } else {
                self.photos = self.randomPhotos
                self.collectionView.reloadData()
            }
        })*/
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //self.photos = self.randomPhotos
        //self.collectionView.reloadData()
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
