//
//  NibLoadableView.swift
//  Contacts
//
//  Created by JagatheshR on 31/08/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import UIKit

protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: .main)}
}
