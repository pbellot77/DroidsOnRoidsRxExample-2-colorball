//
//  ViewController.swift
//  DroidsOnRoidsRxExample#2-colorball
//
//  Created by Patrick Bellot on 1/3/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxSwift
import RxCocoa

class ViewController: UIViewController {
	
	var circleView: UIView!
	private var circleViewModel: CircleViewModel!
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
			setup()
	}
	
	func setup() {
		// Add circle view
		circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
		circleView.layer.cornerRadius = circleView.frame.width / 2.0
		circleView.center = view.center
		circleView.backgroundColor = UIColor.green
		view.addSubview(circleView)
		
		// reference to ViewModel
		circleViewModel = CircleViewModel()
		
		// Rx stack
		circleView
			.rx.observe(CGPoint.self, "center")
			.bindTo(circleViewModel.centerVariable)
			.addDisposableTo(disposeBag)
		
		circleViewModel.backgroundColorObservable
			.subscribe(onNext: { [weak self] (backgroundColor: UIColor?) in
				UIView.animate(withDuration: 0.1) {
					self?.circleView.backgroundColor = backgroundColor
					let viewBackgroundColor = UIColor.init(complementaryFlatColorOf: backgroundColor!)
						if viewBackgroundColor != backgroundColor {
							self?.view.backgroundColor = viewBackgroundColor
					}
				}
			})
			.addDisposableTo(disposeBag) // don't forget the dispose bag!!!
		
		// Add gesture recognizer
		let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(recognizer:)))
		circleView.addGestureRecognizer(gestureRecognizer)
	}
	
	func circleMoved(recognizer: UIPanGestureRecognizer) {
		let location = recognizer.location(in: view)
		UIView.animate(withDuration: 0.1) { 
			self.circleView.center = location
		}
	}
	
} // End of class
