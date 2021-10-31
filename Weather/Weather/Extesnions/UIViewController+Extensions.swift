//
//  UIViewController+Extensions.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import UIKit

protocol ActivityLoading: AnyObject {
    var activityIndicator: UIView? { get set }
    var withBackground: Bool { get }
    var smallViewBackgroundColor: UIColor? { get }
    var backgroundColor: UIColor? { get }
    var indicatorContainerView: UIView? { get }
}

extension ActivityLoading where Self: UIViewController {
func showLoader() {
    if activityIndicator == nil {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let container = indicatorContainerView == nil ? self.view : indicatorContainerView
        guard let containerView = container else { return }
        containerView.insertSubview(backgroundView, at: 1000)
        backgroundView.addSubviewWithBoarder(view: containerView)
        let activity = UIActivityIndicatorView(style: .medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activity)
        activity.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        self.activityIndicator = backgroundView
    }

    if withBackground {
        activityIndicator?.backgroundColor = backgroundColor == nil ? #colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.2392156863, alpha: 0.7015480917) : backgroundColor
    }
    activityIndicator?.isHidden = false
}

    func hideLoader() {
        activityIndicator?.isHidden = true
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}

