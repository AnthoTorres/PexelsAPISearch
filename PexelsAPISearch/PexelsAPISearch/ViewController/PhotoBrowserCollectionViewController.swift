//
//  ViewController.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/12/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit

var errMessage = ErrorMessageStruct()

/// This is the collection view holding all of the photos
class PhotoBrowserCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    /// This Post Model Controller is to help make sure the post functions are seperated from the view controller
    var postMC = PostModelController.shared
            
    var searchInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 64/255, green: 209/255, blue: 178/255, alpha: 1.0)
        return view
    }()
    
    let inputTextField: UITextField = {
       
        let textField = UITextField()
        textField.textColor = .white
        textField.placeholder = "Search image here..."
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        let titleColor: UIColor = .white
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()
    
    var isKeybaordShowing = false
    
    var bottomConstraint: NSLayoutConstraint?
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errMessage.currentView = self
        
        postMC.getPhotos(search: nil) {
            DispatchQueue.main.async {
                self.constraintsSetup()
                self.collectionView.reloadData()
                self.collectionViewLayout.invalidateLayout()
                self.collectionView.layoutIfNeeded()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        calculateCellSize()
    }
    
    // MARK: Helper Functions
    
    func constraintsSetup() {
        collectionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        view.addSubview(searchInputContainerView)
        view.addConstraintsWithFormat("H:|-5-[v0]-5-|", views: searchInputContainerView)
        view.addConstraintsWithFormat("V:[v0(48)]", views: searchInputContainerView)
        
        bottomConstraint = NSLayoutConstraint(item: searchInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50)
        view.addConstraint(bottomConstraint!)
        setupInputComponents()
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        DispatchQueue.main.async {
            if let userInfo = notification.userInfo {
                
                let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
                self.isKeybaordShowing = notification.name == UIResponder.keyboardDidShowNotification
                
                self.bottomConstraint?.constant = self.isKeybaordShowing ? -keyboardFrame!.height - 20 : -50
                
                UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }) { (completed) in
                }
            }
        }
    }
    
    private func setupInputComponents() {
        searchInputContainerView.addSubview(inputTextField)
        searchInputContainerView.addSubview(searchButton)
        
        searchInputContainerView.addConstraintsWithFormat("H:|-40-[v0][v1(60)]-40-|", views: inputTextField, searchButton)
        searchInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: inputTextField)
        searchInputContainerView.addConstraintsWithFormat("V:|[v0]|", views: searchButton)

        searchInputContainerView.curve()
    }
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: searchButton,
            action: #selector(self.search))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func search() {
        
        guard let search = inputTextField.text else {
            return
        }
        
        postMC.refresh()
        postMC.getPhotos(search: search) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionViewLayout.invalidateLayout()
                self.collectionView.layoutIfNeeded()
            }
        }
        
        view.endEditing(true)
    }
    
    func calculateCellSize() {
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        
        collectionViewLayout.collectionView?.collectionViewLayout = layout
    }
    
    // MARK: - Collection View Delegate Methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postMC.postArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // ImageCollectionViewCell is a custom cell I made with the help of a Youtube video (References are in my dev notes...)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let post = postMC.postArray[indexPath.row]
        
        cell.configure(with: post.image)
        collectionView.layoutIfNeeded()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let post = postMC.postArray[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(identifier: "detailViewController") as? DetailViewController else {
            errMessage.showError(with: "Could not present image.", errorType: .error)
            return
        }
        
        viewController.post = post
        
        self.present(viewController, animated: true, completion: nil)
        
        inputTextField.endEditing(true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !postMC.fetchingMore {
                postMC.getPhotos(search: nil) {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.collectionViewLayout.invalidateLayout()
                        self.collectionView.layoutIfNeeded()
                    }
                }
            }
        }
    }
}
