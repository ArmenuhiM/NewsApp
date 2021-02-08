//
//  CommonSplitViewController.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//


class CommonSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        presentsWithGesture = false
        preferredDisplayMode = .allVisible
        maximumPrimaryColumnWidth = 400
        preferredPrimaryColumnWidthFraction = 0.7
    }

    func splitViewController(
             _ splitViewController: UISplitViewController,
             collapseSecondary secondaryViewController: UIViewController,
             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    
    @available(iOS 14.0, *)
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}

