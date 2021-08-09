//
//  ReusableView.swift
//  Contacts
//
//  Created by JagatheshR on 31/08/19.
//  Copyright © 2019 gojek. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject { }

extension ReusableView where Self: UIView {
    static var identifier: String { return String(describing: self) }
}
