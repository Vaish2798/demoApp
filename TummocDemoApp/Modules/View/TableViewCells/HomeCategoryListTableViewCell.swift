//
//  HomeCategoryListTableViewCell.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 24/07/24.
//

import UIKit
protocol HomeCategoryListTableViewCellDelegate: AnyObject {
    func arrowClicked(index: Int)
    func favButtonTapped(index: Int, isFav: Bool)
    func addButtonTapped(index: Int)
}

class HomeCategoryListTableViewCell: UITableViewCell {
    static var xibName = "HomeCategoryListTableViewCell"
    static var cellIdentifier = "HomeCategoryListTableViewCell"
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightCons: NSLayoutConstraint!
    var isClicked = true
    var categoryData = Categories()
    weak var delegate: HomeCategoryListTableViewCellDelegate?
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: HomeProductCollectionViewCell.xibName, bundle: nil), forCellWithReuseIdentifier: HomeProductCollectionViewCell.cellIdentifier)
    }

    @IBAction func arrowButton(_ sender: UIButton) {
        self.delegate?.arrowClicked(index: self.index)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension HomeCategoryListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryData.items?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCollectionViewCell.cellIdentifier, for: indexPath) as! HomeProductCollectionViewCell
        self.categoryName.text = self.categoryData.name ?? ""
        if self.categoryData.items?.count ?? 0 > 0 {
            cell.delegate = self
            cell.index = indexPath.row
            cell.cellSetup(data: self.categoryData.items?[indexPath.row] ?? Item())
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 190)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
extension HomeCategoryListTableViewCell: HomeProductCollectionViewCellDelegate {
    func addButtonTapped(index: Int) {
        delegate?.addButtonTapped(index: index)
    }
    func favButtonTapped(index: Int, isFav: Bool) {
        delegate?.favButtonTapped(index: index, isFav: isFav)
    }
}
