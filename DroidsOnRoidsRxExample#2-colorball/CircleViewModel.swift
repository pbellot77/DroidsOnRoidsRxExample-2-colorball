//
//  CircleViewModel.swift
//  DroidsOnRoidsRxExample#2-colorball
//
//  Created by Patrick Bellot on 1/3/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import Foundation
import ChameleonFramework
import RxSwift
import RxCocoa

class CircleViewModel {
	
	private let disposeBag = DisposeBag()
	var centerVariable = Variable<CGPoint?>(CGPoint.zero) // create one variable that will be changed and observed
	var backgroundColorObservable: Observable<UIColor>! // Create observable that will change background color based on center
	
	init() {
		setup()
	}
	
	func setup() {
		// when we get new center, emit new color
		backgroundColorObservable = centerVariable.asObservable()
			.map { center in
				guard let center = center else { return UIColor.flatten(UIColor.black)() }
				
				let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0
				let green: CGFloat = 0.0
				let blue: CGFloat = 0.0
				
				return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
		}
	}
	
} // end of class
