//
//  HomeViewController.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Variables
    weak var coordinator: MainCoordinator?

    let viewModel = HomeViewModel()

    var pugCell: PugCell?

    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }

    // MARK: - Functions
    func setupUI() {
        view.backgroundColor = .white

        collectionView.registerCell(PugCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 20, right: 16)
        collectionView.collectionViewLayout = layout
    }

    func refreshUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.setNeedsLayout()
            self.collectionView.layoutIfNeeded()
        }
    }

    func loadData() {
        viewModel.loadNextPage(handler: { result in
            switch result {
            case .success:
                self.refreshUI()
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        })
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pug = viewModel.pugs[indexPath.row]
        print("pug: ", pug.image as Any)
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pugs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PugCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let pug = viewModel.pugs[indexPath.row]
        cell.configure(with: pug)
        cell.delegate = self
        pugCell = cell
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offset: CGFloat = 32
        let width: CGFloat = (self.view.frame.width - offset)

        guard let cell = pugCell else {
            return CGSize(width: width, height: width)
        }

        cell.frame.size.width = width
        let pug = viewModel.pugs[indexPath.item]
        cell.configure(with: pug)

        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        let resizing = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)

        return CGSize(width: width, height: resizing.height)
    }
}

//MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 10.0 {
            loadData()
        }
    }
}

extension HomeViewController: PugCellDelegate {
    func didUpdatePug(pug: Pug?) {
        self.viewModel.updatePug(pug: pug)
    }
}
