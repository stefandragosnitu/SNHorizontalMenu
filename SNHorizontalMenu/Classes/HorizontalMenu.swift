//
//  HorizontalMenu.swift
//  TCS
//
//  Created by Stefan on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class HorizontalMenu: UICollectionView {

    //MARK: public variables
    weak open var horizontalMenuDelegate: HorizontalMenuDelegate?
    weak open var horizontalMenuDataSource: HorizontalMenuDataSource?

    open var menuItemSpacing: CGFloat = 0
    open var defaultSelectedItem: Int = 0 {
        didSet {
            self.lastSelectedIndex = IndexPath(item: self.defaultSelectedItem, section: 0)
        }
    }

    //MARK: fileprivate variables
    fileprivate var lastSelectedIndex: IndexPath?

    fileprivate var menuItems: [String] {
        guard let menuDataSource = horizontalMenuDataSource else {
            return [String]()
        }

        return menuDataSource.pageMenuDataSourceItems()
    }

    //MARK: Lifecycle
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize() {
        self.dataSource = self
        self.delegate = self

        setupDynamicCellSize()
        initializeOrientationObserver()
    }

    deinit {
        deInitializeOrientationObserver()
    }

    //MARK: Orientation support
    @objc func didChangeOrientation(notification: Notification) {
        guard let selectedIndex = lastSelectedIndex, let cell = self.cellForItem(at: selectedIndex) as? HorizontalMenuItemCollectionViewCell else {
            return
        }

        self.selectItem(at: selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
        cell.selectionLine.isHidden = false
        self.lastSelectedIndex = selectedIndex
    }
}

//MARK: fileprivate Methods
extension HorizontalMenu {

    fileprivate func setupDynamicCellSize() {
        if let flow = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }

    fileprivate func initializeOrientationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(HorizontalMenu.didChangeOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    fileprivate func deInitializeOrientationObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
}

//MARK: Collection View DataSource
extension HorizontalMenu: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalMenuIdentifiers.pageMenuItem.rawValue, for: indexPath) as! HorizontalMenuItemCollectionViewCell

        // manage initial selection
        if indexPath.item == self.defaultSelectedItem && self.lastSelectedIndex == nil {
            cell.selectionLine.isHidden = false
            self.lastSelectedIndex = indexPath
            self.horizontalMenuDelegate?.didSelectItem(withTitle: self.menuItems[indexPath.item])
        }

        setupCell(cell: cell, indexPath: indexPath)

        return cell
    }

    fileprivate func setupCell(cell: HorizontalMenuItemCollectionViewCell, indexPath: IndexPath) {
        cell.itemLabel.text = menuItems[indexPath.item]
        cell.itemLabel.textColor = self.horizontalMenuDelegate?.menuItemTextColor()
        cell.selectionLine.backgroundColor = self.horizontalMenuDelegate?.menuItemSelectionLineColor()
    }
}

//MARK: Collection View Delegate
extension HorizontalMenu: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //deselect previously selected cell
        if let selectedIndex = self.lastSelectedIndex, let previouslySelectedCell = collectionView.cellForItem(at: selectedIndex) as? HorizontalMenuItemCollectionViewCell {
            previouslySelectedCell.selectionLine.isHidden = true
        }

        let cellToBeSelected = collectionView.cellForItem(at: indexPath) as! HorizontalMenuItemCollectionViewCell

        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        cellToBeSelected.selectionLine.isHidden = false
        self.lastSelectedIndex = indexPath
        self.horizontalMenuDelegate?.didSelectItem(withTitle: self.menuItems[indexPath.item])
    }
}

//MARK: Collection View Flow Layout Delegate
extension HorizontalMenu: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return menuItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
