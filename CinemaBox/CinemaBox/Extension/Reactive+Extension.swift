//
//  Reactive+Extension.swift
//  CinemaBox
//
//  Created by Jack on 06/08/21.
//

import Foundation
import RxSwift

extension Reactive where Base: UIActivityIndicatorView {
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (indicatorView, isVisible) in
            if isVisible {
                indicatorView.startAnimating()
            } else {
                indicatorView.stopAnimating()
            }
        })
    }
}
