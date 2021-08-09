//
//  UITableview+Register.swift
//  News
//
//  Created by JagatheshR on 19/09/19.
//  Copyright © 2019 Byjus. All rights reserved.
//

import UIKit

extension UITableViewCell: NibLoadableView, ReusableView { }

extension UITableView {
    func registerNib<T: UITableViewCell>(_ type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, indexpath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexpath) as? T else { return T() }
        return cell
    }
}

