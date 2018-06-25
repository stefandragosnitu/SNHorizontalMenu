//
// Created by Stefan on 24/06/2018.
// Copyright (c) 2018 Stefan. All rights reserved.
//

import Foundation
import UIKit

public protocol HorizontalMenuDataSource: class {

    func pageMenuDataSourceItems() -> [String]
}

public protocol HorizontalMenuDelegate: class {

    func didSelectItem(withTitle title: String)

    //MARK: optional methods
    func menuItemTextColor() -> UIColor
    func menuItemSelectionLineColor() -> UIColor
}

extension HorizontalMenuDelegate {

    func menuItemTextColor() -> UIColor {
        return UIColor.black
    }

    func menuItemSelectionLineColor() -> UIColor {
        return UIColor.blue
    }
}